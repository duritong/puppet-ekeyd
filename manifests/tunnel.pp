class ekeyd-tunnel {

  include site-stunnel

  # set the ekeyd bind address/port that the actual ekeyd will use and this
  # tunnel will connect to
  $ekeyd_address = '127.0.0.1'
  $ekeyd_port = '8889'

  # the ekeyd class ensures that we're not on a vserver or xen domU
  # so we're either on a vhost, a xen dom0, or a plain old machine, all of
  # which might be places we'd want to run this class
  include ekeyd 

  # stunnel service that listens on pn 8888/SSL and sends to localhost
  # 8889/nonSSL
  stunnel::service {
    "ekeyd":
      accept => "${ekeyd_tunnel_address}:8888",
      connect => "127.0.0.1:8889",
      client => false,
      chroot => false,
      pid => "/var/run/stunnel4/ekeyd.pid",
      cafile => "/etc/certs/roots/${domain}.pem",
      cert => "/etc/certs/stunnel/certs/${fqdn}/${fqdn}_server.crt",
      key => "/etc/certs/stunnel/keys/${fqdn}/${fqdn}_server.key",
      verify => "2",
      rndfile => "/var/lib/stunnel4/.rnd",
      debuglevel => "4";
  }

}

class egd-tunnel {

  include site-stunnel

  # set the ekeyd bind address that egd will connect to, which is stunnel on
  # localhost, then the tunnel will connect to the tunnel on the ekeyd server
  $ekeyd_address = '127.0.0.1'

  # the egd class ensures that we're not on a vserver, so we're either
  # on a vhost, a xen dom0, a xen domU, or a plain old machine, all of
  # which might be places we'd want to run this class
  include egd 

  # stunnel service that listens on localhost 8888/nonSSL and sends to 
  # pn 8888/SSL on the ekeyd server
  stunnel::service {
    "egd":
      accept => "127.0.0.1:8888",
      connect => "${ekeyd_tunnel_address}:8888",
      client => true,
      chroot => false,
      pid => "/var/run/stunnel4/egd.pid",
      cafile => "/etc/certs/roots/${domain}.pem",
      cert => "/etc/certs/stunnel/certs/${fqdn}/${fqdn}_client.crt",
      key => "/etc/certs/stunnel/keys/${fqdn}/${fqdn}_client.key",
      verify => "2",
      rndfile => "/var/lib/stunnel4/.rnd",
      debuglevel => "4";
  }

  # egd needs stunnel to be up, but by default egd starts before stunnel
  # (both are started at rc2.d/s20). So we need to adjust egd.
  # See #576387

  # On machines where we use loop-aes, we need to move egd to
  # runlevel 3 (since stunnel starts there too since it needs the certs
  # in /crypt). Unfortunately we don't have a variable to tell us
  # if a machine is running loop-aes. But since all of our machines
  # use either dmcrypt or loop-aes and we have a way to know if they
  # are using the former, then we can just do all machines NOT using
  # dmcrypt. If someone ends up using this on machines without
  # encryption, this will break.
  if ( ! $root_is_encrypted ) {
    # We're on a loop-aes machine
    exec {
      "fix_egd_priority":
        command => "/bin/sh -c 'update-rc.d -f ekeyd-egd-linux remove && update-rc.d ekeyd-egd-linux start 21 3 . stop 21 0 1 2 4 5 6 .'",
        onlyif => '/usr/bin/test -L /etc/rc3.d/S20ekeyd-egd-linux';
    }
  }
  else {
    # We're on a dmcrypt machine
    exec {
      "fix_egd_priority":
        command => "/bin/sh -c 'update-rc.d -f ekeyd-egd-linux remove && update-rc.d ekeyd-egd-linux defaults 21'",
        onlyif => '/usr/bin/test -L /etc/rc3.d/S20ekeyd-egd-linux';
    }
  }
}

# manage base stuff
class ekeyd::base {

  package{'ekeyd':
    ensure => installed,
  }
  if $ekeyd::mode == 'uds' {
    $rekey_cmd = "ekey-rekey `ekeydctl list | grep \"/var/run/entropykeys\" | awk -F/ '{ print \$5 }'` ${ekeyd::masterkey}"
    package{'ekeyd-uds':
      ensure => installed,
      before => Package['ekeyd'],
    }
  } else {
    $rekey_cmd = "ekey-rekey `ekeydctl list | grep \"/dev/entropykey\" | awk -F, '{ print \$5 }'` ${ekeyd::masterkey}"
  }

  # TODO (from riseup code)
  # * eventually it would be cool if we could have two classes: one for
  # SetOutputToKernel and one for EGDTCPSocket. But for now we're just going
  # to have puppet deliver the ekeyd.conf file.
  # * ekeyd will be setup to feed output to whatever is configured in the
  #   variables: $ekeyd_host and $ekeyd_port with the defaults being
  #   127.0.0.1 and 8888
  $conf_content = $::operatingsystem ? {
    'debian' => template("ekeyd/ekeyd.conf_${::lsbdistcodename}.erb"),
    default => template('ekeyd/ekeyd.conf_default.erb'),
  }
  file{'/etc/entropykey/ekeyd.conf':
    content => $conf_content,
    require => Package['ekeyd'],
    notify  => Service['ekeyd'],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
  service{'ekeyd':
    ensure => running,
    enable => true,
  }

  exec{'configure_ekeyd_key':
    command => $rekey_cmd,
    unless  => 'ekeydctl list | grep -q \'Running OK\'',
    require => Service['ekeyd'],
  }
}

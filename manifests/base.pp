# manage base stuff
class ekeyd::base {

  package{'ekeyd':
    ensure => installed,
  }
  if $ekeyd::mode == 'uds' {
    package{'ekeyd-uds':
      ensure => installed,
      before => Package['ekeyd'],
    }
  }

  file{'/etc/entropykey/ekeyd.conf':
    content => template('ekeyd/ekeyd.conf_default.erb'),
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
    command => "ekey-rekey \$(ekeydctl list | grep ',/dev' | awk -F, '{ print \$5 }') ${ekeyd::masterkey}",
    unless  => 'ekeydctl list | grep -q \'Running OK\'',
    require => Service['ekeyd'],
  }
  sysctl::value{'kernel.random.write_wakeup_threshold':
    value => 1024
  }
  if $ekeyd::host {
    Service['ekeyd']{
      before => Service['egd-linux']
    }
  }
}

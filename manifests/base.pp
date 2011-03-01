class ekeyd::base {

  package{'ekeyd':
    ensure => installed,
  }

  file{'/etc/entropykey/ekeyd.conf':
    source => 'puppet:///modules/ekeyd/ekeyd.conf',
    require => Package['ekeyd'],
    notify => Service['ekeyd'],
    owner => root, group => 0, mode => 0644;
  }
  service{'ekeyd':
    ensure => running,
    enable => true,
  }

  exec{'configure_ekey_key':
    command => "ekey-rekey `ekeydctl list | grep \"/dev/entropykey\" | awk -F, '{ print \$5}'` ${ekey_masterkey}",
    unless => "ekeydctl list | grep -q 'Running OK'",
    require => Service['ekeyd'],
  } 
}

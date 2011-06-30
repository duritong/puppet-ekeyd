class ekeyd::base {

  package{'ekeyd':
    ensure => installed,
  }

  file{'/etc/entropykey/ekeyd.conf':
    content => $operatingsystem ? {
      'debian' => template("ekeyd/ekeyd.conf_${lsbdistcodename}.erb"),
       default => template("ekeyd/ekeyd.conf_default.erb"),
    },
    require => Package['ekeyd'],
    notify => Service['ekeyd'],
    owner => root, group => 0, mode => 0644;
  }
  service{'ekeyd':
    ensure => running,
    enable => true,
  }

  exec{'configure_ekeyd_key':
    command => "ekey-rekey `ekeydctl list | grep \"/dev/entropykey\" | awk -F, '{ print \$5}'` ${ekeyd::ekeyd_masterkey}",
    unless => "ekeydctl list | grep -q 'Running OK'",
    require => Service['ekeyd'],
  } 
}

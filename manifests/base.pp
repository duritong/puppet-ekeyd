class ekeyd::base {

  package{'ekeyd':
    ensure => installed,
  }

  service{'ekeyd':
    ensure => running,
    enable => true,
    require => Package['ekeyd'],
  }

  exec{'configure_ekey_key':
      command => "ekey-rekey `ekeydctl list | grep \"/dev/entropykey\" | awk -F, '{ print \$5}'` ${ekey_masterkey}",
      unless => "ekeydctl list | grep -q 'Running OK'",
      require => Service['ekeyd'],
  } 
}

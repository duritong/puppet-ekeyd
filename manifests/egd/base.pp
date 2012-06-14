class ekeyd::egd::base {
  package{'ekeyd-egd-linux':
    ensure => present,
    before => Service['egd-linux'],
  }

  service{'egd-linux':
    enable => true,
    ensure => running,
  }

  if $ekeyd::egd::manage_shorewall {
    Service['egd-linux']{
      require => Service['shorewall'],
    }
  }
}

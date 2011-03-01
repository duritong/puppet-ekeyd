class ekeyd::egd {
  package{'ekeyd-egd-linux':
    ensure => present,
    before => Service['egd-linux'],
  }

  service{'egd-linux':
    enable => true,
    ensure => running,
  }

  if $use_shorewall {
    Service['egd-linux']{
      require => Service['shorewall'],
    }
  }
}

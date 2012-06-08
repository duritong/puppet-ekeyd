class ekeyd::egd::base {
  package{'ekeyd-egd-linux':
    ensure => present,
    before => Service['egd-linux'],
  }

  service{'egd-linux':
    enable => true,
    ensure => running,
  }

  if hiera('use_shorewall',false) {
    Service['egd-linux']{
      require => Service['shorewall'],
    }
  }
}

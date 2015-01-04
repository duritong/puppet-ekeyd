# basic setup of ekeyd-egd-linux
class ekeyd::egd::base {
  package{'ekeyd-egd-linux':
    ensure => present,
    before => Service['egd-linux'],
  }

  service{'egd-linux':
    ensure => running,
    enable => true,
  }
  if $ekeyd::params::use_systemd {
    Service['egd-linux']{
      name => "egd-linux@${ekeyd::egd::host}"
    }
  }

  if $ekeyd::egd::manage_shorewall {
    Service['egd-linux']{
      require => Service['shorewall'],
    }
  }
}

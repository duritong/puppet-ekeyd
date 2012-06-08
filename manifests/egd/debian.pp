class ekeyd::egd::debian inherits ekeyd::egd::base {

  Package["ekeyd-egd-linux"] {
    ensure => $::lsbdistcodename ? {
      "lenny" => "1.1.3-3~bpo50+1",
      default => 'installed'
    }
  }

  Service["egd-linux"] {
    name => 'ekeyd-egd-linux',
    hasstatus => true,
    subscribe => File["/etc/default/ekeyd-egd-linux"],
  }

  file { "/etc/default/ekeyd-egd-linux":
    content => template("ekeyd/ekeyd-egd-linux.default.erb"),
    mode    => 644,
    owner   => root,
    group   => root,
    require => Package["ekeyd-egd-linux"];
  }
}

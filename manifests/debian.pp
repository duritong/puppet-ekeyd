class ekeyd::debian inherits ekeyd::base {
  package { "usbutils": ensure => installed }

  if ( $virtual == "vserver" ) or ( $virtual == "xenu" ) {
    fail("This class shouldn't be included on vservers or xen domUs")
  }

  file { "/etc/default/ekeyd":
    source  => "puppet:///modules/ekeyd/debian/ekeyd.default",
    mode    => 644,
    owner   => root,
    group   => root,
    require => File["/etc/entropykey/ekeyd.conf"];
  }

  Service["ekeyd"] {
    subscribe  => [ File["/etc/default/ekeyd"], File["/etc/entropykey/ekeyd.conf"] ];
    pattern    => '/usr/sbin/ekeyd',
    hasrestart => true,
  }
}

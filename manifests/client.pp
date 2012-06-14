class ekeyd::client(
  $host,
  $shorewall_zones = ['net'],
  $manage_shorewall
) {
  case $::operatingsystem {
    centos: { include ekeyd::client::centos }
    default: { include ekeyd::client::base }
  }

  if $manage_shorewall {
    shorewall::rules::out::ekeyd{$ekeyd::client::shorewall_zones:
      host => $ekeyd::client::host,
    }
  }
}

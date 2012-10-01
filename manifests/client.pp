class ekeyd::client(
  $host,
  $port             = '8888',
  $shorewall_zones  = ['net'],
  $manage_shorewall = false,
  $manage_monit     = false
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

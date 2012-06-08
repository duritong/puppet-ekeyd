class ekeyd::client(
  $host,
  $shorewall_zones = ['net']
) {
  case $::operatingsystem {
    centos: { include ekeyd::client::centos }
    default: { include ekeyd::client::base }
  }

  if hiera('use_shorewall',false) {
    shorewall::rules::out::ekeyd{$ekeyd::client::shorewall_zones:
      host => $ekeyd::client::host,
    }
  }
}

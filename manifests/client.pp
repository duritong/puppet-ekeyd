class ekeyd::client(
  $ekeyd_host,
  $shorewall_zones = ['net']
) {
  case $operatingsystem {
    centos: { include ekeyd::client::centos }
    debian: { include ekeyd::client::debian }
    default: { include ekeyd::client::base }
  }

  if $use_shorewall {
    shorewall::rules::out::ekeyd{$shorewall_zones:
      ekeyd_host => $ekeyd_host,
    }
  }
}

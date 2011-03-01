class ekeyd::client(
  $ekeyd_host
) {
  case $operatingsystem {
    centos: { include ekeyd::client::centos }
    default: { include ekeyd::client::base }
  }

  if $use_shorewall {
    class{'shorewall::rules::out::ekeyd':
      ekeyd_host => $ekeyd_host,
    }
  }
}

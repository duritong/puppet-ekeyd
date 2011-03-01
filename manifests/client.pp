class ekeyd::client {
  if !$ekeyd_host { fail("\$ekeyd_host is not set for $fqdn") }
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

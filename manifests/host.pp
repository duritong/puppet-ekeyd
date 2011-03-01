class ekeyd::host inherits ekeyd {
  case $operatingsystem {
    centos: { include ekeyd::host::centos }
    default: { include ekeyd::host::base }
  }

  if $use_shorewall {
    include shorewall::rules::ekeyd
  }
}

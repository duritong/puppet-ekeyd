class ekeyd(
  $host = false,
  $masterkey,
  $manage_munin     = false,
  $manage_shorewall = false,
  $mode = $::operatingsystem ? {
    centos => 'uds',
    default => 'direct'
  },
  $manage_monit     = true
){

  if $::ekeyd_key_present != 'true' { fail("Can't find an ekey key plugged into usb on ${::fqdn}") }

  case $::operatingsystem {
    debian: { include ekeyd::debian }
    centos: { include ekeyd::centos }
    default: { include ekeyd::base }
  }

  if $ekeyd::host {
    case $::operatingsystem {
      centos: { include ekeyd::host::centos }
      default: { include ekeyd::host::base }
    }

    if $ekeyd::manage_shorewall {
      include shorewall::rules::ekeyd
    }
  }

  if $ekeyd::manage_munin {
    include ekeyd::munin
  }
  
  if $ekeyd::manage_monit {
    include ekeyd::monit
  }
}

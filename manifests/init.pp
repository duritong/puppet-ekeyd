class ekeyd(
  $host = false,
  $masterkey
){

  if $::ekeyd_key_present != 'true' { fail("Can't find an ekey key plugged into usb on ${::fqdn}") }

  case $::operatingsystem {
    debian: { include ekeyd::debian }
    default: { include ekeyd::base }
  }

  if $ekeyd::host {
    case $::operatingsystem {
      centos: { include ekeyd::host::centos }
      default: { include ekeyd::host::base }
    }

    if hiera('use_shorewall',false) {
      include shorewall::rules::ekeyd
    }
  }

  if hiera('use_munin',false) {
    include ekeyd::munin
  }
}

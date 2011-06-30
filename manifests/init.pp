class ekeyd(
  $ekeyd_host = false,
  $ekeyd_masterkey
){

  package { "usbutils": ensure => installed }
 
  if $ekeyd_key_present != 'true' { fail("Can't find an ekey key plugged into usb on ${fqdn}") }

  include ekeyd::base

  if $ekeyd_host {
    case $operatingsystem {
      centos: { include ekeyd::host::centos }
      default: { include ekeyd::host::base }
    }

    if $use_shorewall {
      include shorewall::rules::ekeyd
    }
  }

  if $use_munin {
    include ekeyd::munin
  }
}

class ekeyd(
  $ekey_host = false,
  $ekey_masterkey
){

  if $ekeyd_key_present != 'true' { fail("Can't find an ekey key plugged into usb on ${fqdn}") }

  include ekeyd::base

  if $ekey_host {
    case $operatingsystem {
      centos: { include ekeyd::host::centos }
      default: { include ekeyd::host::base }
    }

    if $use_shorewall {
      include shorewall::rules::ekeyd
    }
  }
}

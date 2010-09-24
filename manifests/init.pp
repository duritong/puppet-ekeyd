class ekeyd {

  if $ekeyd_key_present != 'true' { fail("Can't find an ekey key plugged into usb on ${fqdn}") }
  if !$ekey_masterkey { fail("You need to define \$ekey_masterkey for ${fqdn}") }

  include ekeyd::base
}

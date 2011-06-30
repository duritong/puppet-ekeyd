class ekeyd::host::debian inherits ekeyd::host::base {
  package { "usbutils": ensure => installed }
}

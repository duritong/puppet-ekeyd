# centos specialities
class ekeyd::centos inherits ekeyd::base {
  if $ekeyd::mode == 'uds' {
    $ensure = $::lsbmajdistrelease ? {
      5       => present,
      default => absent
    }
    Package['ekeyd-uds']{
      name => 'ekeyd-ulusbd',
      ensure => $ensure,
    }
  }
}

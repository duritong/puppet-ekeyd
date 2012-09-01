class ekeyd::centos inherits ekeyd::base {
  if $ekeyd::mode == 'uds' {
    Package['ekeyd-uds']{
      name => 'ekeyd-ulusbd',
      ensure => $lsbmajdistrelease ? {
        5 => present,
        default => absent
      }
    }
  }
}

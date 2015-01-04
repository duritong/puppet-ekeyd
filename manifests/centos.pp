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
  if $ekeyd::host and !$ekeyd::params::use_systemd {
    file{'/etc/sysconfig/egd-linux':
      ensure => 'absent',
      notify => Service['egd-linux'],
    }
  }
}

class ekeyd::host::centos inherits ekeyd::host::base {
  file{'/etc/sysconfig/egd-linux':
    ensure => 'absent',
    notify => Service['egd-linux'],
  }
}

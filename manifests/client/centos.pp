class ekeyd::client::centos inherits ekeyd::client::base {
  file{'/etc/sysconfig/egd-linux':
    content => "DAEMON_HOST=${ekeyd::client::host}\n",
    notify => Service['egd-linux'],
    owner => root, group => 0, mode => 0644;
  }
}

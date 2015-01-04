# manage host
class ekeyd::egd::centos inherits ekeyd::egd::base {
  if !$ekeyd::params::use_systemd and ekeyd::egd::host {
    file{'/etc/sysconfig/egd-linux':
      content => "DAEMON_HOST=${ekeyd::egd::host}\n",
      notify  => Service['egd-linux'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    }
  }
}

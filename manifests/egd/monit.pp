class ekeyd::egd::monit {
  $service_name = $::operatingsystem ? {
    debian  => 'ekeyd-egd-linux',
    default => 'egd-linux'
  }
  $service_cmd = $::operatingsystem ? {
    debian => '/usr/sbin/service',
    default => '/sbin/service'
  }
  monit::check::process{"egd-linux":
    pidfile     => "/var/run/${service_name}.pid",
    start       => "${service_cmd} ${service_name} start",
    stop        => "${service_cmd} ${service_name} stop",
    customlines => [ 'if 5 restarts within 5 cycles then timeout' ],
    require => Service['egd-linux']
  }
}
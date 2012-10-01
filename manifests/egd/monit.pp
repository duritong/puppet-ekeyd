class ekeyd::egd::monit {
  $service_name = $::operatingsystem ? {
    debian  => 'ekeyd-egd-linux',
    default => 'egd-linux'
  }
  monit::check::process{"egd-linux":
    pidfile     => "/var/run/${service_name}.pid",
    start       => "/sbin/service ${service_name} start",
    stop        => "/sbin/service ${service_name} stop",
    customlines => [ 'if 5 restarts within 5 cycles then timeout' ],
    require => Service['egd-linux']
  }
}
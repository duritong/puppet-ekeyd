class ekeyd::monit {
  $service_cmd = $::operatingsystem ? {
    debian => '/usr/sbin/service',
    default => '/sbin/service'
  }
  monit::check::process{"ekeyd":
    pidfile     => "/var/run/ekeyd.pid",
    start       => "${service_cmd} ekeyd start",
    stop        => "${service_cmd} ekeyd stop",
    customlines => $ekeyd::host ? {
      false     => [ 'if 5 restarts within 5 cycles then timeout' ],
      default   => [ 'if failed host 127.0.0.1 port 8888 then restart',
                     'if 5 restarts within 5 cycles then timeout' ]
    },
    require => Service['ekeyd'],
  }
}
class ekeyd::monit {
  monit::check::process{"ekeyd":
    pidfile     => "/var/run/ekeyd.pid",
    start       => "/sbin/service ekeyd start",
    stop        => "/sbin/service ekeyd stop",
    customlines => $ekeyd::host ? {
      false     => [ 'if 5 restarts within 5 cycles then timeout' ],
      default   => [ 'if failed host 127.0.0.1 port 8888 then restart',
                     'if 5 restarts within 5 cycles then timeout' ]
    },
    require => Service['ekeyd'],
  }
}
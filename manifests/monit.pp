class ekeyd::monit {
  $customlines = [ 'if 5 restarts within 5 cycles then timeout' ]
  
  if $ekeyd::host {
    $customlines += [ 'if failed host 127.0.0.1 port 8888 then restart' ]
  }
  
  monit::check::process{"ekeyd":
    pidfile     => "/var/run/ekeyd.pid",
    start       => "/sbin/service ekeyd start",
    stop        => "/sbin/service ekeyd stop",
    customlines => $customlines,
    require => Service['ekeyd'],
  }
}
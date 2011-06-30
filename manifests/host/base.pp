class ekeyd::host::base inherits ekeyd::base {
  sysctl::value{'kernel.random.write_wakeup_threshold':
    value => 1024
  }

  File['/etc/entropykey/ekeyd.conf']{
    source => 'puppet:///modules/ekeyd/ekeyd.conf.daemon',
  }

  Service['ekeyd']{
    before => Service['egd-linux'],
  }

  include ekeyd::egd
}

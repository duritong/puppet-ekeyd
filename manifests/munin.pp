class ekeyd::munin {
  munin::plugin::deploy{'ekeyd_stat_':
    source => "ekeyd/munin/ekeyd_stat_" ,
    ensure => "absent",
  }
  munin::plugin{
    [ 'ekeyd_stat_total_EntropyRate',
      'ekeyd_stat_total_TotalEntropy',
      'ekeyd_stat_total_KeyVoltage',
      'ekeyd_stat_total_FipsFrameRate',
      'ekeyd_stat_KeyTemperatureC' ]:
      require => Munin::Plugin::Deploy['ekeyd_stat_'],
      ensure => 'ekeyd_stat_',
      config => "'user root\nenv.controlsocket /var/run/ekeyd.sock",
  }
}

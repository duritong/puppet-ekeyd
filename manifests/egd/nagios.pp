class ekeyd::egd::nagios {
  nagios::service { "ekeyd-egd-linux":
    check_command => "nagios-stat-proc!/usr/sbin/ekeyd-egd-linux!1!1!proc",
  }
}

class ekeyd::nagios {
  nagios::service { "ekeyd":
    check_command => "nagios-stat-proc!/usr/sbin/ekeyd!1!1!proc";
  }
}

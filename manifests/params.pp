# helper class for ekeyd and egd stuff
class ekeyd::params {
  if $::operatingsystem in ['RedHat', 'CentOS'] and $::operatingsystemmajrelease > 6 {
    $use_systemd = true
  } else {
    $use_systemd = false
  }
}

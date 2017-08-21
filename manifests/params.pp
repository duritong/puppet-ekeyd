# helper class for ekeyd and egd stuff
class ekeyd::params {
  if $::operatingsystem in ['RedHat', 'CentOS'] and versioncmp($::operatingsystemmajrelease,'6') > 0 {
    $use_systemd = true
  } else {
    $use_systemd = false
  }
}

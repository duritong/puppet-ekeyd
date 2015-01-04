# manage the egd-linux daemon
class ekeyd::egd (
  $host             = false,
  $manage_shorewall = false,
  $manage_monit     = false,
  $port             = '8888',
  $shorewall_zones  = ['net'],
) {
  if ( $::virtual == 'vserver' ) {
    fail('This class shouldn\'t be included on vservers')
  }

  include ekeyd::params
  if $manage_shorewall and $host {
    shorewall::rules::out::ekeyd{$shorewall_zones:
      host => $host,
    }
  }

  case $::operatingsystem {
    debian: { include ekeyd::egd::debian }
    centos: { include ekeyd::egd::centos }
    default: { include ekeyd::egd::base }
  }

  if $ekeyd::egd::manage_monit and !$ekeyd::params::use_systemd {
    include ekeyd::egd::monit
  }
}

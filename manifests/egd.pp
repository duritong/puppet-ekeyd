# manage the egd-linux daemon
class ekeyd::egd (
  $manage_shorewall = false,
  $manage_monit     = false,
) {
  if ( $::virtual == 'vserver' ) {
    fail('This class shouldn\'t be included on vservers')
  }

  include ekeyd::params

  case $::operatingsystem {
    debian: { include ekeyd::egd::debian }
    default: { include ekeyd::egd::base }
  }

  if $ekeyd::egd::manage_monit and !$ekeyd::params::use_systemd {
    include ekeyd::egd::monit
  }
}

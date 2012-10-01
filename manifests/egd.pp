class ekeyd::egd ( 
  $manage_shorewall = false,
  $manage_monit     = false
) {
  if ( $::virtual == "vserver" ) {
    fail("This class shouldn't be included on vservers")
  }

  case $::operatingsystem {
    debian: { include ekeyd::egd::debian }
    default: { include ekeyd::egd::base }
  }
  
  if $ekeyd::egd::manage_monit {
    include ekeyd::egd::monit
  }
}

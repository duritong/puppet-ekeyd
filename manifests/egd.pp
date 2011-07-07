class ekeyd::egd {
  if ( $virtual == "vserver" ) {
    fail("This class shouldn't be included on vservers")
  }

  case $operatingsystem {
    debian: { include ekeyd::egd::debian }
    default: { include ekeyd::egd::base }
  }
}

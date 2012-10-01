class ekeyd::client::base {
  class{'ekeyd::egd':
    manage_shorewall => $ekeyd::client::manage_shorewall,
    manage_monit     => $ekeyd::client::manage_monit,
  }
}

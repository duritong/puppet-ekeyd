# manage an ekeyd key installation
class ekeyd(
  $masterkey,
  $host             = false,
  $manage_munin     = false,
  $manage_shorewall = false,
  $mode             = $::operatingsystem ? {
    centos => $::operatingsystemmajrelease ? {
      '5'     => 'uds',
      default => 'direct',
    },
    default => 'direct',
  },
  $manage_monit     = true
){

  if !$::ekeyd_key { fail("Can't find an ekey key plugged in on ${::fqdn}") }

  include ekeyd::params

  case $::operatingsystem {
    debian:   { include ekeyd::debian }
    centos:   { include ekeyd::centos }
    default:  { include ekeyd::base }
  }

  if $ekeyd::host {
    if $ekeyd::manage_shorewall {
      include shorewall::rules::ekeyd
    }
    class { 'ekeyd::egd' :
      host             => '127.0.0.1',
      manage_shorewall => $ekeyd::manage_shorewall,
      manage_monit     => $ekeyd::manage_monit
    }
  }

  if $ekeyd::manage_munin {
    include ekeyd::munin
  }

  if $ekeyd::manage_monit and !$ekeyd::params::use_systemd {
    include ekeyd::monit
  }
}

# == Class: bgp_spamd
#
# Full description of class bgp_spamd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'bgp_spamd':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class bgp_spamd (
  $spamtraps = undef,
  $asnumber = $::bgp_spamd::asnumber,
  $pftable  = $::bgp_spamd::pftable,
  $bgpd_enable = $::bgp_spamd::bgpd_enable,
  $bgpd_ensure = $::bgp_spamd::bgpd_ensure,
  $bgpd_flags   = $::bgp_spamd::bgpd_flags,
  $spamd_enable = $::bgp_spamd::spamd_enable,
  $spamd_ensure = $::bgp_spamd::spamd_ensure,
  $spamd_flags  = $::bgp_spamd::spamd_flags,
) inherits bgp_spamd::params {

  class { 'bgp_spamd::config':
    asnumber  => $asnumber,
    pftable   => $pftable,
    spamtraps => $spamtraps,
  }

  class { 'bgp_spamd::spamtraps': 
    spamtraps => $spamtraps,
  }

  class { 'bgp_spamd::service':
    bgpd_enable  => $bgpd_enable,
    bgpd_ensure  => $bgpd_ensure,
    bgpd_flags   => $bgpd_flags,
    spamd_enable => $spamd_enable,
    spamd_ensure => $spamd_ensure,
    spamd_flags  => $spamd_flags,
    spamlogd_enable => $spamlogd_enable,
    spamlogd_ensure => $spamlogd_ensure,
    spamlogd_flags  => $spamlogd_flags,
  }

  Class['bgp_spamd::config'] -> 
  Class['bgp_spamd::service'] ->
  Class['bgp_spamd::spamtraps']

}

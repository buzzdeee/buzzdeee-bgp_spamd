# This class takes care of the 
# default values
class bgp_spamd::params {
  $asnumber = 65001
  $pftable  = 'bgp-spamd-bypass'
  $bgpd_enable = true
  $bgpd_ensure = 'running'
  $bgpd_flags   = ''
  $spamd_enable = true
  $spamd_ensure = 'running'
  $spamd_flags  = ''
  $spamlogd_enable = true
  $spamlogd_ensure = 'running'
  $spamlogd_flags  = '-l pflog1'
}

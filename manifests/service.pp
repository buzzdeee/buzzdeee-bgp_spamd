class bgp_spamd::service (
  $bgpd_ensure,
  $bgpd_enable,
  $bgpd_flags,
  $spamd_ensure,
  $spamd_enable,
  $spamd_flags,
  $spamlogd_ensure,
  $spamlogd_enable,
  $spamlogd_flags,
) {
  service { 'bgpd':
    ensure => $bgpd_ensure,
    enable => $bgpd_enable,
    flags  => $bgpd_flags,
  }
  service { 'spamd':
    ensure => $spamd_ensure,
    enable => $spamd_enable,
    flags  => $spamd_flags,
  }
  service { 'spamlogd':
    ensure => $spamlogd_ensure,
    enable => $spamlogd_enable,
    flags  => $spamlogd_flags,
  }
}

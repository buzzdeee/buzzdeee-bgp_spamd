class bgp_spamd::spamtraps (
  $spamtraps,
){
  each($spamtraps) |$trap| {
    exec { "spamtrap $trap":
      command => "/usr/sbin/spamdb -T -a '$trap'",
      onlyif  => "/bin/[ ! `spamdb | grep SPAMTRAP | grep '$trap'` ]",
    }
  }
}

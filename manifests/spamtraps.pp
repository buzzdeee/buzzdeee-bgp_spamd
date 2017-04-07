# This class takes care to manage the spamtraps
class bgp_spamd::spamtraps (
  Array $spamtraps,
){
  if $spamtraps {
    each(unique(downcase($spamtraps))) |$trap| {
      exec { "spamtrap ${trap}":
        command => "/usr/sbin/spamdb -T -a '${trap}'",
        onlyif  => "/bin/[ ! `spamdb | grep SPAMTRAP | grep '${trap}'` ]",
      }
    }
  }
}

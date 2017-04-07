# This class takes care to manage the spamtraps
class bgp_spamd::spamtraps (
  $spamtraps,
){
  if $spamtraps {
    each($spamtraps) |$trap| {
      $lowercase_trap = downcase($trap)
      exec { "spamtrap ${trap}":
        command => "/usr/sbin/spamdb -T -a '${trap}'",
        onlyif  => "/bin/[ ! `spamdb | grep SPAMTRAP | grep '${lowercase_trap}'` ]",
      }
    }
  }
}

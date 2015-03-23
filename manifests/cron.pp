class bgp_spamd::cron {
  cron { 'update spamd from bgp':
    command => '/usr/sbin/bgp-spamd-update.sh',
    minute  => '*/10',
  }
  cron { 'send greylisted mails':
    command => '/usr/sbin/spamdb | grep GREY | grep -v "<sebastia@l00-bugdead-prods.de>" | sort -t "|" -k 5',
    minute  => '55',
  }

  file { '/usr/sbin/bgp-spamd-update.sh':
    owner   => 'root',
    group   => '0',
    mode    => '0750',
    content => template("bgp_spamd/bgp-spamd-update.sh.erb"),
  }
}

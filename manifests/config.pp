class bgp_spamd::config (
  $asnumber,
  $pftable,
  $spamtraps,
  $spamd_whitelist,
  $bruteforce_whitelist,
){
  file { '/etc/bgpd.conf':
    owner   => 'root',
    group   => '0',
    mode    => '0600',
    content => template("bgp_spamd/bgpd.conf.erb")
  }

  file { '/etc/mail/spamd.conf':
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template("bgp_spamd/spamd.conf.erb")
  }

  file { '/etc/pf.conf':
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => template("bgp_spamd/pf.conf.erb")
  }
  file { '/etc/mail/nospamd':
    ensure  => 'file',
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => template('bgp_spamd/iplist.erb'),
  }
  file { '/etc/nobruteforce':
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => template('bgp_spamd/iplist.erb'),
  }

  file { '/etc/hostname.pflog1':
    ensure  => 'present',
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => "up\n",
    notify  => Exec['start pflog1'],
  }

  file { '/usr/local/bin/bgp-spamd-update.sh':
    owner   => 'root',
    group   => '0',
    mode    => '0750',
    content => template("bgp_spamd/bgp-spamd-update.sh.erb"),
  }

  file { '/var/www/htdocs/index.html':
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('bgp_spamd/index.html.erb'),
  }
  exec { 'start pflog1':
    command     => '/bin/sh /etc/netstart pflog1',
    refreshonly => true,
  }

  cron { 'send greylisted mails':
    command => '/usr/sbin/spamdb | grep GREY | grep -v "<sebastia@l00-bugdead-prods.de>" | sort -t "|" -k 5',
    minute  => '55',
  }

  exec { 'reload pf':
    command => '/sbin/pfctl -f /etc/pf.conf',
    refreshonly => true,
    subscribe => [File['/etc/pf.conf'], File['/etc/mail/nospamd'], File['/etc/nobruteforce']],
  }
}

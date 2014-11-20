class bgp_spamd::config (
  $asnumber,
  $pftable,
  $spamtraps,
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
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => template("bgp_spamd/nospamd.erb")
  }
  file { '/etc/hostname.pflog1':
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    content => "up\n",
  }
  file { '/var/www/htdocs/index.html':
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('bgp_spamd/index.html.erb'),
  }
  Exec { 'start pflog1':
    command => '/bin/sh /etc/netstart pflog1',
    subscribe => File['/etc/hostname.pflog1'],
  }

  Exec { 'reload pf':
    command => '/sbin/pfctl -f /etc/pf.conf',
    subscribe => [File['/etc/pf.conf'], File['/etc/mail/nospamd']],
  }
}

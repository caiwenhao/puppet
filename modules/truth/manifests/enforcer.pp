class truth::enforcer {
  if has_role("db") {
   class {'::systeminit::package::install':}
   #class {'::systeminit::mysql::install':}
   #class { 'nginx': }
    class { '::php':
      manage_repos => false,
      fpm           => true,
      dev           => true,
      composer     => false,
      pear          => false,
      phpunit      => false,
      extensions   => {},
    }

  } else {
    class { '::systeminit':
    ps1          => "tgzt_puppet_agent_${ipaddress_eth0}_61618_A",
    enable_lnmp  => true,}
  }
}


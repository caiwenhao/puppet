class truth::enforcer {
  if has_role("db") {
   class {'::systeminit::package::install':}
   class { 'nginx': }
   #class {'::systeminit::mysql::install':}
  } else {
    class { '::systeminit':
    ps1          => "tgzt_puppet_agent_${ipaddress_eth0}_61618_A",
    enable_lnmp  => true,}
  }
}


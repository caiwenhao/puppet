class truth::enforcer {
  if has_role("db") {
class { '::systeminit':
  ps1          => "tgzt_puppet_agent_${ipaddress_eth0}_61618_A",
  enable_lnmp  => true,}

    notify {"I am a database":}
  } else {
    notify {"I am not a database":}
  }


}


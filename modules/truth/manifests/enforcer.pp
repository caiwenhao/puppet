class truth::enforcer {
  if has_role("db") {
    class { '::ntp':
          restrict => ['127.0.0.1'],
          interfaces => ['127.0.0.1'],
          service_manage  => true,
    }
    class { 'timezone':
          timezone => 'Asia/Shanghai',
    }
    
    class { 'ssh':
          manage_firewall               => true,
          sshd_config_port              => '61618',
          sshd_password_authentication  => 'no',
          sshd_config_use_dns           => 'no',
          hiera_merge                   => true,
    }

   class { 'dnsclient':
	nameservers => ['121.10.118.123','114.114.114.114','223.5.5.5','223.6.6.6','112.124.47.27','202.96.128.143','202.96.128.166','202.96.128.86'],
}
firewall { '0001':
  ensure     => 'present',
  action     => 'accept',
  iniface    => 'lo',
  proto      => 'all',
}
firewall { '0002':
  ensure     => 'present',
  action     => 'accept',
  isfragment => 'false',
  proto      => 'all',
  state      => ['ESTABLISHED', 'RELATED'],
}

firewall { '0003 accept for private network':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '192.168.11.0/24',
}
firewall { '0004 accept for 125.90.88.48':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '125.90.88.48/32',
}
firewall { '0005 accept for private network':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '113.107.160.72/32',
}
firewall { '0006 accept for private network':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '219.129.216.215/32',
}
firewall { '0007 accept commom rule':
  ensure     => 'present',
  action     => 'accept',
  dport      => ['80','443','843','4369','8000-8300','9000-9300','11000-15000','80','20000-30000'],
  proto      => 'tcp',
}
firewall { '0008 accept for SSH':
  ensure     => 'present',
  action     => 'accept',
  dport      => ['61618'],
  proto      => 'tcp',
}

firewall { '0009 accept ping':
  ensure     => 'present',
  action     => 'accept',
  icmp       => '8',
  proto      => 'icmp',
}

  ssh_authorized_key { 'caiwenhao@live.com':
  user => 'root',
  type => 'ssh-rsa',
  ensure => 'present',
  key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqVkglLmJket+NbXy0vtsWUc5vcuMyS7xgkiml9qodleWmfi2kTwTUTstrrDHEdobQ0U251vFTZMM9Y9tlRVftfpgp4UIBKelHe+ZnzW6GifiFU9VOqyaEOGWHN0WLyWacxocNZrWvIZ1430qV95QTMkzqpRTtuySexSysL5oO08gQCT7h4MjwOwo1nm438VJXbFg7l1T8L6gUD1ZJDgwZz3+NGZ3eszZm4jssDFWsWSaOPrvoYJ6pUtH51FdnwcblMvvrKvXKbE1VMuIce2GrYAjHZs7dAG+i6w5H2HYwXrNySqZd8azkDtfY8/xispP85SwR5uH1VIQcDuLVkQ4h',
}
 user {"change root":
	name => 'root',
	ensure => 'present',
	password => sha1($uuid),
}





    notify {"I am a database":}
  } else {
    notify {"I am not a database":}
  }


}


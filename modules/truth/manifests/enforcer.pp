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



    class { 'ssh':
          manage_firewall               => true,
          sshd_config_port              => '61618',
          sshd_password_authentication  => 'no',
          sshd_config_use_dns           => 'no',
          hiera_merge                   => true,
    }
    notify {"I am a database":}
  } else {
    notify {"I am not a database":}
  }


}


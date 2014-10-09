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
	  sshd_config_loglevel          => 'VERBOSE',
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
    package { [ "augeas-devel",
                "augeas" ]:
        ensure => "present",
        allow_virtual => false,
    }

class {'augeasproviders::instances':
	sysctl_hash => { 
        'net.ipv4.ip_forward' => { 'value' => '0' },
        'net.ipv4.conf.default.rp_filter' => { 'value' => '1' },
        'net.ipv4.conf.default.accept_source_route' => { 'value' => '0' },
        'kernel.sysrq' => { 'value' => '0' },
        'kernel.core_uses_pid' => { 'value' => '1' },
        'net.ipv4.tcp_syncookies' => { 'value' => '1' },
        'kernel.msgmnb' => { 'value' => '0' },
        'kernel.msgmax' => { 'value' => '65536' },
        'kernel.shmmax' => { 'value' => inline_template("<%= memorysize_mb.to_i*1024*1024 %>") },
	'kernel.shmall' => { 'value' => inline_template("<%= memorysize_mb.to_i*1024/4 %>") },
        'kernel.shmmni' => { 'value' => '4096' },
        'net.nf_conntrack_max' => { 'value' => '655360' },
        'net.netfilter.nf_conntrack_max' => { 'value' => '655360' },
        'net.netfilter.nf_conntrack_tcp_timeout_established' => { 'value' => '1200' },
        'net.ipv4.tcp_window_scaling' => { 'value' => '1' },
	'net.ipv4.tcp_sack' => { 'value' => '1' },
	'net.ipv4.tcp_timestamps' => { 'value' => '0' },
	'net.ipv4.tcp_synack_retries' => { 'value' => '2' },
	'net.ipv4.tcp_syn_retries' => { 'value' => '2' },
	'net.ipv4.tcp_tw_reuse' => { 'value' => '1' },
	'net.ipv4.tcp_tw_recycle' => { 'value' => '1' },
	'net.ipv4.ip_local_port_range' => { 'value' => '1024 65000' },
	'net.ipv4.tcp_max_syn_backlog' => { 'value' => '8192' },
	'net.ipv4.ip_local_reserved_ports' => { 'value' => '3306,4369,8000-8300,9000-9300,20000-30000,61618' },
	'net.ipv4.tcp_fin_timeout' => { 'value' => '30' },
	'net.ipv4.tcp_retries2' => { 'value' => '5' },
	'net.ipv4.tcp_max_tw_buckets' => { 'value' => '180000' },
	'net.core.somaxconn' => { 'value' => '1024' },
	'kernel.core_pattern' => { 'value' => '/data/tmp/core' },
	'net.nf_conntrack_max' => { 'value' => '655360' },
	'net.netfilter.nf_conntrack_max' => { 'value' => '655360' },
	'net.netfilter.nf_conntrack_tcp_timeout_established' => { 'value' => '1200' },
	},

}

logrotate::rule { 'messages':
  path         => '/var/log/cron /var/log/maillog /var/log/messages /var/log/secure /var/log/spooler',
  rotate       => 5,
  rotate_every => 'week',
  sharedscripts => true,
  postrotate   => '/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true',
}

class { '::mysql::server':
  remove_default_accounts => true,
  restart => true,
  root_password    => 'strongpassword',
  override_options => {
        'mysqld' => {
                'datadir' => '/usr/local/mysql/var/',
                'max_connections' => '1024',
                'default-storage-engine' => 'INNODB',
                'bind-address' => '0.0.0.0',
                'key_buffer_size' => '16M',
                'query_cache_limit' => '2M',
                'query_cache_size' => '128M',
                'thread_cache_size' => '300',
                'sort_buffer_size' => '8M',
                'read_buffer_size' => '4M',
                'read_rnd_buffer_size' => '256M',
                'myisam_sort_buffer_size' => '32M',
                'back_log' => '512',
                'tmp_table_size' => '246M',
                'thread_concurrency' => $processorcount,
                'innodb_buffer_pool_size' => '6G',
                'innodb_log_file_size' => '512M',
                'innodb_log_buffer_size' => '8M',
                'innodb_flush_log_at_trx_commit' => '2',
                'open_files_limit' => '65535',
                'innodb_file_per_table' => '1',
                'max_connections' => '1024',
                 },
         'isamchk' => {
                'key_buffer' => '1M',
                'sort_buffer_size' => '1M',
                'read_buffer' => '2M',
                'write_buffer' => '2M',
         },     
         'myisamchk' => {
                'key_buffer' => '1M',
                'sort_buffer_size' => '1M',
                'read_buffer' => '2M',
                'write_buffer' => '2M',
         }, 
         'mysqldump' => {
                'max_allowed_packet' => '16M',
                'quick' => true,
                'quote-names' => true,
         }, 
         'mysql' => {
                'auto-rehash' => true,
         }, 
    }
}

class { '::mysql::bindings':
  php_enable => true,
  python_enable =>true,
}

class { 'nginx':
 worker_connections => 8,
 worker_rlimit_nofile => 8,
 proxy_set_header => ['Host $host','X-Real-IP $remote_addr','X-Forwarded-For $proxy_add_x_forwarded_for'],
 confd_purge => true,
 vhost_purge => true,
 }



    notify {"I am a database":}
  } else {
    notify {"I am not a database":}
  }


}


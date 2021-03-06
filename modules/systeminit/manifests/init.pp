class systeminit
(
  $ps1          = undef,
  $enable_lnmp 	= false,
  $server_list  = inline_template("<%= `ls -d /data/*_* 2>/dev/null|sort -t_ -k2n -k3n|wc -l` %>"),
) 
{

#判断是否线上服
if ($server_list != 0){
  notify {"已经存在业务数据，请检查！":}
}

#禁用selinux
class { 'selinux':
 mode => 'disabled'
}

#设置终端环境语言
augeas {"i18n" :
  context => "/etc/sysconfig/i18n",
  changes => [ 
  "set LANG en_US.UTF-8",
  "set SYSFONT latarcyrheb-sun16",]
}

file { "/root/.bash_profile":
  content => template('systeminit/bash_profile.erb'),
  mode    => '0644',
}

#配置dns
class { 'dnsclient':
  nameservers => ['121.10.118.123','114.114.114.114','223.5.5.5','223.6.6.6','112.124.47.27','202.96.128.143','202.96.128.166','202.96.128.86'],
}

#设置时区
class { 'timezone':
      timezone => 'Asia/Shanghai',
}

#sysctl配置
class {'augeasproviders::instances':
  sysctl_hash => { 
    'net.ipv4.ip_forward'                                => { 'value' => '0' },
    'net.ipv4.conf.default.rp_filter'                    => { 'value' => '1' },
    'net.ipv4.conf.default.accept_source_route'          => { 'value' => '0' },
    'kernel.sysrq'                                       => { 'value' => '0' },
    'kernel.core_uses_pid'                               => { 'value' => '1' },
    'net.ipv4.tcp_syncookies'                            => { 'value' => '1' },
    'kernel.msgmnb'                                      => { 'value' => '0' },
    'kernel.msgmax'                                      => { 'value' => '65536' },
    'kernel.shmmax'                                      => { 'value' => inline_template("<%= memorysize_mb.to_i*1024*1024 %>") },
    'kernel.shmall'                                      => { 'value' => inline_template("<%= memorysize_mb.to_i*1024/4 %>") },
    'kernel.shmmni'                                      => { 'value' => '4096' },
    'net.nf_conntrack_max'                               => { 'value' => '655360' },
    'net.netfilter.nf_conntrack_max'                     => { 'value' => '655360' },
    'net.netfilter.nf_conntrack_tcp_timeout_established' => { 'value' => '1200' },
    'net.ipv4.tcp_window_scaling'                        => { 'value' => '1' },
    'net.ipv4.tcp_sack'                                  => { 'value' => '1' },
    'net.ipv4.tcp_timestamps'                            => { 'value' => '0' },
    'net.ipv4.tcp_synack_retries'                        => { 'value' => '2' },
    'net.ipv4.tcp_syn_retries'                           => { 'value' => '2' },
    'net.ipv4.tcp_tw_reuse'                              => { 'value' => '1' },
    'net.ipv4.tcp_tw_recycle'                            => { 'value' => '1' },
    'net.ipv4.ip_local_port_range'                       => { 'value' => '1024 65000' },
    'net.ipv4.tcp_max_syn_backlog'                       => { 'value' => '8192' },
    'net.ipv4.ip_local_reserved_ports'                   => { 'value' => '3306,4369,8000-8300,9000-9300,20000-30000,61618' },
    'net.ipv4.tcp_fin_timeout'                           => { 'value' => '30' },
    'net.ipv4.tcp_retries2'                              => { 'value' => '5' },
    'net.ipv4.tcp_max_tw_buckets'                        => { 'value' => '180000' },
    'net.core.somaxconn'                                 => { 'value' => '1024' },
    'kernel.core_pattern'                                => { 'value' => '/data/tmp/core' },
  },

}

#日志分割
logrotate::rule { 'messages':
  path         => '/var/log/cron /var/log/maillog /var/log/messages /var/log/secure /var/log/spooler',
  rotate       => 5,
  rotate_every => 'week',
  sharedscripts => true,
  postrotate   => '/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true',
}

  class { 'nginx': }
  class {'::systeminit::service::config':}
  #class {'::systeminit::ssh::config':}
  class {'::systeminit::firewall::config':}
  class {'::systeminit::mysql::install':}
  class {'erlang':}

}

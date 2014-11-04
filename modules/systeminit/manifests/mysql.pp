class systeminit::mysql::install {

$root_password = inline_template("<%= `tr -dc _A-Z,a-z:1-9. </dev/urandom |head -c20` %>")

file {"mv_mysql":
  path   => "/data/database/mysql",
  ensure => "absent",
  backup => ".$uptime_seconds.bak",
  force  => true,
  purge  => true,
}
->
exec {"mk_mysql":
  command => "/bin/mkdir -p /data/database/mysql;/bin/rm -f /root/.my.cnf ",
  path    => ["/usr/bin","/usr/sbin","/bin","/sbin"]
}
->
file {"/var/lib/mysql":
  ensure => link,
  target => "/data/database/mysql",
}
->
file {"/data/save":ensure => "directory",}
->
file {"/data/save/mysql_root":content => $root_password,}

file { '/root/mysql_start':
  content => '/sbin/service mysql start',
  mode    => '700',
}

file { '/root/mysql_stop':
  content => '/sbin/service mysql stop',
  mode    => '700',
}

file { '/root/mysql_processlist':
  content => "mysql -uroot -p`cat /data/save/mysql_root` -e 'SHOW processlist;",
  mode    => '700',
}

class { '::mysql::server':
  remove_default_accounts => true,
  restart                 => true,
  root_password          => $root_password,
  old_root_password      => "",
  package_name           => "Percona-Server-server-55",
  service_name           => "mysql",
  override_options => {
        'mysqld' => {
                'max_allowed_packet' => '16M',
                'max_connections' => '1024',
                'default-storage-engine' => 'INNODB',
                'bind-address' => '0.0.0.0',
                'key_buffer' => '16M',
                'query_cache_limit' => '2M',
                'query_cache_size' => '128M',
                'thread_cache_size' => '300',
                'sort_buffer_size' => '8M',
                'net_buffer_length' => '8k',
                'read_buffer_size' => '4M',
                'read_rnd_buffer_size' => '256M',
                'myisam_sort_buffer_size' => '32M',
                'back_log' => '512',
                'skip-name-resolve' => undef,
                'tmp_table_size' => '246M',
                'thread_concurrency' => $processorcount,
                'innodb_buffer_pool_size' => '10M',
                'innodb_autoextend_increment' => "128M",
                'innodb_log_file_size' => '512M',
                'innodb_log_buffer_size' => '8M',
                'innodb_flush_log_at_trx_commit' => '2',
                'open_files_limit' => '65535',
                'innodb_file_per_table' => '1',
                'innodb_open_files' => '20480',
                'max_connections' => '1024',
                'pid-file' => '/var/lib/mysql/mysqld.pid',
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
        'mysqld_safe' => {
                'log-error' => "/var/log/mysql_error.log",
        },
  }
}

class { '::mysql::bindings':
  php_enable => true,
  python_enable =>true,
  perl_enable   => true,
}
}
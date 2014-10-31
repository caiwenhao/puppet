class systeminit::mysql::install {

$root_password = inline_template("<%= `tr -dc _A-Z,a-z:1-9. </dev/urandom |head -c20` %>")

exec { ["mkdir -p /data/save/","mkdir -p /data/database/mysql/"]:
  path => ["/usr/bin","/usr/sbin","/bin","/sbin",]
}

file {"/data/save/mysql_root":
  content => $root_password,
}

file { '/root/mysql_start':
  content => '/sbin/service mysqld start',
  mode    => '700',
}

file { '/root/mysql_stop':
  content => '/sbin/service mysqld stop',
  mode    => '700',
}

file { '/root/mysql_processlist':
  content => "mysql -uroot -p`cat /data/save/mysql_root` -e 'SHOW processlist;'",
  mode    => '700',
}

class { '::mysql::server':
  remove_default_accounts => true,
  restart                 => true,
  root_password           => $root_password,
  package_ensure          => '5.1.73-3.el6_5',
  override_options => {
        'mysqld' => {
                'datadir' => '/data/database/mysql/',
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
                'innodb_buffer_pool_size' => inline_template("<%= (memorysize_mb.to_i*0.6).to_s.split('.')[0] + 'M' %>"),
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
}
# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters
# are managed via puppet-module-data (see data/ dir)
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged NGINX
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
#  stdlib
#    - puppetlabs-stdlib module >= 0.1.6
#    - plugin sync enabled to obtain the anchor type
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include nginx
# }
class nginx (
  $worker_cpu_affinity            = 'auto',
  $client_body_buffer_size        = '16k',
  $client_body_temp_path          = '/tmp/nginx_client_temp 1 2',
  $client_max_body_size           = '2m',
  $confd_purge                    = false,
  $configtest_enable              = true,
  $conf_dir                       = '/etc/nginx',
  $conf_template                  = 'nginx/conf.d/nginx.conf.erb',
  $daemon_user                    = 'nginx',
  $events_use                     = false,
  $fastcgi_cache_inactive         = '20m',
  $fastcgi_cache_key              = false,
  $fastcgi_cache_keys_zone        = 'd3:100m',
  $fastcgi_cache_levels           = '1',
  $fastcgi_cache_max_size         = '500m',
  $fastcgi_cache_path             = false,
  $fastcgi_cache_use_stale        = false,
  $gzip                           = 'off',
  $http_access_log                = 'off',
  $http_cfg_append                = false,
  $http_tcp_nodelay               = 'on',
  $http_tcp_nopush                = 'on',
  $keepalive_timeout              = '10',
  $logdir                         = '/var/log/nginx/',
  $mail                           = false,
  $manage_repo                    = undef,
  $multi_accept                   = 'on',
  $names_hash_bucket_size         = '64',
  $names_hash_max_size            = '512',
  $nginx_error_log                = '/var/log/nginx/error.log crit',
  $nginx_locations                = {},
  $nginx_mailhosts                = {},
  $nginx_upstreams                = {},
  $nginx_vhosts                   = {},
  $nginx_vhosts_defaults          = {},
  $package_ensure                 = undef,
  $package_name                   = undef,
  $package_source                 = undef,
  $pid                            = '/var/run/nginx.pid',
  $proxy_buffers                  = '32 4k',
  $proxy_buffer_size              = '8k',
  $proxy_cache_inactive           = '20m',
  $proxy_cache_keys_zone          = 'd2:100m',
  $proxy_cache_levels             = '1',
  $proxy_cache_max_size           = '500m',
  $proxy_cache_path               = false,
  $proxy_conf_template            = 'nginx/conf.d/proxy.conf.erb',
  $proxy_connect_timeout          = '90',
  $proxy_headers_hash_bucket_size = '64',
  $proxy_http_version             = '1.0',
  $proxy_read_timeout             = '90',
  $proxy_redirect                 = 'off',
  $proxy_send_timeout             = '90',
  $proxy_set_header               = ['Host             $host','X-Real-IP        $remote_addr','X-Forwarded-For  $proxy_add_x_forwarded_for'],
  $proxy_temp_path                = '/var/nginx/proxy_temp',
  $run_dir                        = '/var/nginx',
  $sendfile                       = 'on',
  $server_tokens                  = 'off',
  $service_ensure                 = true,
  $service_restart                = true,
  $spdy                           = 'off',
  $super_user                     = true,
  $temp_dir                       = '/tmp',
  $types_hash_bucket_size         = '512',
  $types_hash_max_size            = '1024',
  $vhost_purge                    = false,
  $worker_connections             = '51200',
  $worker_processes               = $processorcount,
  $worker_rlimit_nofile           = '65535',
  $global_owner                   = 'root',
  $global_group                   = 'root',
  $global_mode                    = '0644',
  $sites_available_owner          = 'root',
  $sites_available_group          = '0644',
  $sites_available_mode           = '0644',
  $geo_mappings                   = {},
  $string_mappings                = {},
) {

  ### DEPRECATION WARNING ###
  ###
  ### During the transition from the params pattern -> puppet-module-data,
  ### we need a graceful way to notify the consumer that the pattern is
  ### changing, and point them toward docs on how to transition.
  ###
  ### Once we hit 1.0, this whole block goes away.
  ###
  ### Please note: as a contributor to this module, no Pulls will be accepted
  ### that do add additional parameters to this class. Get on this puppet-module-data
  ### level!

  ### This block makes me sad, but what can you do.... we need to do this
  ### migration the Right Way(tm) -- JDF

  if $client_body_buffer_size or
	 $client_body_temp_path or
	 $client_max_body_size or
	 $confd_purge or
	 $conf_dir or
	 $conf_template or
	 $daemon_user or
	 $events_use or
	 $fastcgi_cache_inactive or
	 $fastcgi_cache_key or
	 $fastcgi_cache_keys_zone or
	 $fastcgi_cache_levels or
	 $fastcgi_cache_max_size or
	 $fastcgi_cache_path or
	 $fastcgi_cache_use_stale or
	 $gzip or
	 $http_access_log or
	 $http_cfg_append or
	 $http_tcp_nodelay or
	 $http_tcp_nopush or
	 $keepalive_timeout or
	 $logdir or
	 $mail or
	 $multi_accept or
	 $names_hash_bucket_size or
	 $names_hash_max_size or
	 $nginx_error_log or
	 $pid or
	 $proxy_buffers or
	 $proxy_buffer_size or
	 $proxy_cache_inactive or
	 $proxy_cache_keys_zone or
	 $proxy_cache_levels or
	 $proxy_cache_max_size or
	 $proxy_cache_path or
	 $proxy_conf_template or
	 $proxy_connect_timeout or
	 $proxy_headers_hash_bucket_size or
	 $proxy_http_version or
	 $proxy_read_timeout or
	 $proxy_redirect or
	 $proxy_send_timeout or
	 $proxy_set_header or
	 $proxy_temp_path or
	 $run_dir or
	 $sendfile or
	 $server_tokens or
	 $spdy or
	 $super_user or
	 $temp_dir or
	 $types_hash_bucket_size or
	 $types_hash_max_size or
	 $vhost_purge or
	 $worker_connections or
	 $worker_processes or
	 $worker_rlimit_nofile or
	 $global_owner or
	 $global_group or
	 $global_mode or
	 $sites_available_owner or
	 $sites_available_group or
	 $sites_available_mode {

	  include nginx::notice::puppet_module_data
	}

  ### END DEPRECATION WARNING ###

  class { 'nginx::package':
    package_name   => $package_name,
    package_source => $package_source,
    package_ensure => $package_ensure,
    notify         => Class['nginx::service'],
    manage_repo    => $manage_repo,
  }

  class { 'nginx::config':
    client_body_buffer_size        => $client_body_buffer_size,
    client_body_temp_path          => $client_body_temp_path,
    client_max_body_size           => $client_max_body_size,
    confd_purge                    => $confd_purge,
    conf_dir                       => $conf_dir,
    conf_template                  => $conf_template,
    daemon_user                    => $daemon_user,
    events_use                     => $events_use,
    fastcgi_cache_inactive         => $fastcgi_cache_inactive,
    fastcgi_cache_key              => $fastcgi_cache_key,
    fastcgi_cache_keys_zone        => $fastcgi_cache_keys_zone,
    fastcgi_cache_levels           => $fastcgi_cache_levels,
    fastcgi_cache_max_size         => $fastcgi_cache_max_size,
    fastcgi_cache_path             => $fastcgi_cache_path,
    fastcgi_cache_use_stale        => $fastcgi_cache_use_stale,
    gzip                           => $gzip,
    http_access_log                => $http_access_log,
    http_cfg_append                => $http_cfg_append,
    http_tcp_nodelay               => $http_tcp_nodelay,
    http_tcp_nopush                => $http_tcp_nopush,
    keepalive_timeout              => $keepalive_timeout,
    logdir                         => $logdir,
    mail                           => $mail,
    multi_accept                   => $multi_accept,
    names_hash_bucket_size         => $names_hash_bucket_size,
    names_hash_max_size            => $names_hash_max_size,
    nginx_error_log                => $nginx_error_log,
    pid                            => $pid,
    proxy_buffers                  => $proxy_buffers,
    proxy_buffer_size              => $proxy_buffer_size,
    proxy_cache_inactive           => $proxy_cache_inactive,
    proxy_cache_keys_zone          => $proxy_cache_keys_zone,
    proxy_cache_levels             => $proxy_cache_levels,
    proxy_cache_max_size           => $proxy_cache_max_size,
    proxy_cache_path               => $proxy_cache_path,
    proxy_conf_template            => $proxy_conf_template,
    proxy_connect_timeout          => $proxy_connect_timeout,
    proxy_headers_hash_bucket_size => $proxy_headers_hash_bucket_size,
    proxy_http_version             => $proxy_http_version,
    proxy_read_timeout             => $proxy_read_timeout,
    proxy_redirect                 => $proxy_redirect,
    proxy_send_timeout             => $proxy_send_timeout,
    proxy_set_header               => $proxy_set_header,
    proxy_temp_path                => $proxy_temp_path,
    run_dir                        => $run_dir,
    sendfile                       => $sendfile,
    server_tokens                  => $server_tokens,
    spdy                           => $spdy,
    super_user                     => $super_user,
    temp_dir                       => $temp_dir,
    types_hash_bucket_size         => $types_hash_bucket_size,
    types_hash_max_size            => $types_hash_max_size,
    vhost_purge                    => $vhost_purge,
    worker_connections             => $worker_connections,
    worker_processes               => $worker_processes,
    worker_rlimit_nofile           => $worker_rlimit_nofile,
    global_owner                   => $global_owner,
    global_group                   => $global_group,
    global_mode                    => $global_mode,
    sites_available_owner          => $sites_available_owner,
    sites_available_group          => $sites_available_group,
    sites_available_mode           => $sites_available_mode,
    require                        => Class['nginx::package'],
    notify                         => Class['nginx::service'],
  }

  class { 'nginx::service': }

  create_resources('nginx::resource::upstream', $nginx_upstreams)
  create_resources('nginx::resource::vhost', $nginx_vhosts, $nginx_vhosts_defaults)
  create_resources('nginx::resource::location', $nginx_locations)
  create_resources('nginx::resource::mailhost', $nginx_mailhosts)
  create_resources('nginx::resource::map', $string_mappings)
  create_resources('nginx::resource::geo', $geo_mappings)

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  anchor{ 'nginx::begin':
    before => Class['nginx::package'],
    notify => Class['nginx::service'],
  }
  anchor { 'nginx::end':
    require => Class['nginx::service'],
  }
}

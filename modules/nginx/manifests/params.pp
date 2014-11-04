# Class: nginx::params
#
# Parameters for and from the nginx module.
#
# Parameters :
#  none
#
# Sample Usage :
#  include nginx::params
#
class nginx::params {
  # The easy bunch
  $service = 'nginx'
  $confdir = '/etc/nginx'
  # user
  case $::operatingsystem {
    'Debian',
    'Ubuntu': { $user = 'www-data' }
     default: { $user = 'nginx' }
  }
  # package
  case $::operatingsystem {
    'Gentoo': { $package = 'www-servers/nginx' }
     default: { $package = 'nginx' }
  }

### END DEPRECATION WARNING ###
# service restart
case $::operatingsystem {
'Fedora',
'RedHat',
'CentOS': {
$service_start = '/sbin/service nginx start'
$service_restart = '/sbin/service nginx reload'
$service_stop = '/sbin/service nginx stop'
},
default: {
$service_start = '/etc/init.d/nginx start'
$service_restart = '/etc/init.d/nginx reload'
$service_stop = '/etc/init.d/nginx stop'
}
}

  # remove_default_conf
  case $::operatingsystem {
    'Fedora',
    'RedHat',
    'CentOS': { $remove_default_conf = true }
     default: { $remove_default_conf = false }
  }
  # include /etc/nginx/vhost/*
  case $::operatingsystem {
    'Debian',
    'Ubuntu': { $sites_enabled = true }
     default: { $sites_enabled = false }
  }
}


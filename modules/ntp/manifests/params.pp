class ntp::params {

  $autoupdate        = false
  $config_template   = 'ntp/ntp.conf.erb'
  $disable_monitor   = false
  $keys_enable       = false
  $keys_controlkey   = ''
  $keys_requestkey   = ''
  $keys_trusted      = []
  $logfile           = undef
  $package_ensure    = 'present'
  $preferred_servers = []
  $service_enable    = true
  $service_ensure    = 'running'
  $service_manage    = true
  $udlc              = false
  $interfaces        = []

  # On virtual machines allow large clock skews.
  $panic = str2bool($::is_virtual) ? {
    true    => false,
    default => true,
  }

  $default_config       = '/etc/ntp.conf'
  $default_keys_file    = '/etc/ntp/keys'
  $default_driftfile    = '/var/lib/ntp/drift'
  $default_package_name = ['ntp']
  $default_service_name = 'ntpd'

  case $::osfamily {
    'AIX': {
      $config        = $default_config
      $keys_file     = '/etc/ntp.keys'
      $driftfile     = '/etc/ntp.drift'
      $package_name  = [ 'bos.net.tcp.client' ]
      $restrict      = [
        'default nomodify notrap nopeer noquery',
        '127.0.0.1',
      ]
      $service_name  = 'xntpd'
      $iburst_enable = true
      $servers       = [
        '0.debian.pool.ntp.org',
        '1.debian.pool.ntp.org',
        '2.debian.pool.ntp.org',
        '3.debian.pool.ntp.org',
      ]
    }
    'Debian': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = $default_package_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntp'
      $iburst_enable   = true
      $servers         = [
        '0.debian.pool.ntp.org',
        '1.debian.pool.ntp.org',
        '2.debian.pool.ntp.org',
        '3.debian.pool.ntp.org',
      ]
    }
    'RedHat': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = $default_package_name
      $service_name    = $default_service_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        'time.nist.gov',
        '0.asia.pool.ntp.org',
        '1.asia.pool.ntp.org',
        '2.asia.pool.ntp.org',
        '3.asia.pool.ntp.org',
        'time-a.nist.gov',
        'time.windows.com',
        'ntp.fudan.edu.cn',
        '61.129.42.44',
        '43.119.133.233',
      ]
    }
    'Suse': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = '/var/lib/ntp/drift/ntp.drift'
      $package_name    = $default_package_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = 'ntp'
      $iburst_enable   = false
      $servers         = [
        '10.142.39.37',
        '10.142.25.101',
        '2.opensuse.pool.ntp.org',
        '3.opensuse.pool.ntp.org',
      ]
    }
    'FreeBSD': {
      $config          = $default_config
      $driftfile       = '/var/db/ntpd.drift'
      $keys_file       = $default_keys_file
      $package_name    = ['net/ntp']
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = $default_service_name
      $iburst_enable   = true
      $servers         = [
        '0.freebsd.pool.ntp.org maxpoll 9',
        '1.freebsd.pool.ntp.org maxpoll 9',
        '2.freebsd.pool.ntp.org maxpoll 9',
        '3.freebsd.pool.ntp.org maxpoll 9',
      ]
    }
    'Archlinux': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = $default_package_name
      $service_name    = $default_service_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
      ]
    }
    'Solaris': {
      $config        = '/etc/inet/ntp.conf'
      $driftfile     = '/var/ntp/ntp.drift'
      $keys_file     = '/etc/inet/ntp.keys'
      $package_name  = $::operatingsystemrelease ? {
        /^(5\.10|10|10_u\d+)$/ => [ 'SUNWntpr', 'SUNWntpu' ],
        /^(5\.11|11|11\.\d+)$/ => [ 'service/network/ntp' ]
      }
      $restrict      = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name  = 'network/ntp'
      $iburst_enable = false
      $servers       = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
        '3.pool.ntp.org',
      ]
    }
    # Gentoo was added as its own $::osfamily in Facter 1.7.0
    'Gentoo': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = ['net-misc/ntp']
      $service_name    = $default_service_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        '0.gentoo.pool.ntp.org',
        '1.gentoo.pool.ntp.org',
        '2.gentoo.pool.ntp.org',
        '3.gentoo.pool.ntp.org',
      ]
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      # Before Facter 1.7.0 Gentoo did not have its own $::osfamily
      case $::operatingsystem {
        'Gentoo': {
          $config          = $default_config
          $keys_file       = $default_keys_file
          $driftfile       = $default_driftfile
          $service_name    = $default_service_name
          $package_name    = ['net-misc/ntp']
          $restrict        = [
            'default kod nomodify notrap nopeer noquery',
            '-6 default kod nomodify notrap nopeer noquery',
            '127.0.0.1',
            '-6 ::1',
          ]
          $iburst_enable   = false
          $servers         = [
            '0.gentoo.pool.ntp.org',
            '1.gentoo.pool.ntp.org',
            '2.gentoo.pool.ntp.org',
            '3.gentoo.pool.ntp.org',
          ]
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}

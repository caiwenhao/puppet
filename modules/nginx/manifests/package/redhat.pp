# Class: nginx::package::redhat
#
# This module manages NGINX package installation on RedHat based systems
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::package::redhat (
  $manage_repo    = false,
  $package_ensure = '1.6.2-23.el6.art',
  $package_name   = 'nginx',
) {

  if $::lsbmajdistrelease {
    $major_dist_release = $::lsbmajdistrelease
  }
  else {
    $major_dist_release = $::operatingsystemmajrelease
  }

  case $::operatingsystem {
    'fedora': {
      # nginx.org does not supply RPMs for fedora
      # fedora 18 provides 1.2.x packages
      # fedora 19 has 1.4.x packages are in

      # fedora 18 users will need to supply their own nginx 1.4 rpms and/or repo
      if $::lsbmajdistrelease and $::lsbmajdistrelease < 19 {
        notice("${::operatingsystem} ${::lsbmajdistrelease} does not supply nginx >= 1.4 packages")
      }
    }
    default: {
      case $major_dist_release {
        5, 6, 7: {
          $os_rel = $major_dist_release
        }
        default: {
          # Amazon uses the year as the $::lsbmajdistrelease
          $os_rel = 6
        }
      }

      # as of 2013-07-28
      # http://nginx.org/packages/centos appears to be identical to
      # http://nginx.org/packages/rhel
      # no other dedicated dirs exist for platforms under $::osfamily == redhat
      if $manage_repo {
        yumrepo { 'nginx-release':
          baseurl  => "http://nginx.org/packages/rhel/${os_rel}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package[$package_name],
        }

        file { '/etc/yum.repos.d/nginx-release.repo':
          ensure  => present,
          require => Yumrepo['nginx-release'],
        }
      }
    }
  }

  package { $package_name:
    ensure  => $package_ensure,
    allow_virtual => false,
    require => Class["::systeminit::package::install"],
  }

}

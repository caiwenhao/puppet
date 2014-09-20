class test::ntp {
    package { "ntp":
      ensure => installed,
      allow_virtual => false,
    }

    service { "ntpd":
      ensure => running,
      require => Package["ntp"],
    }

    file { "/etc/ntp.conf":
      source => "puppet:///san/admin/ntp.conf",
      notify => Service["ntpd"],
      require => Package["ntp"],
    }
}

#
class mysql::server::install {

  package { 'mysql-server':
    ensure        => $mysql::server::package_ensure,
    name          => $mysql::server::package_name,
    allow_virtual => false,
  }
->
  exec {"mysql_install_db":
    command =>"/usr/bin/mysql_install_db --datadir=/data/database/mysql --user=mysql",
    onlyif =>"/bin/mkdir /data/database/mysql/mysql",
    require => Exec["mk_mysql"],
  }

}

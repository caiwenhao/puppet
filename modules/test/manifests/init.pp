class test{
   file {"/tmp/$hostname.txt":content=>"hello world!";}
}

class test_file{
   file { "/tmp/users.htpasswd":
    source => "puppet:///san/passwords.txt",}
}

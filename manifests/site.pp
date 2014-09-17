#node default { file { "/tmp/cwh":content => "20140911";}}
#node default {file { "/tmp/users.htpasswd":source => "puppet:///san/admin/users.htpasswd",}}
node default {file { "/tmp/cwh":mode => "440",source => "puppet:///san/admin/cwh",backup => ".bak",}}

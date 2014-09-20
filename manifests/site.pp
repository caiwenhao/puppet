#node default { file { "/tmp/cwh":content => "20140911";}}
#node default {file { "/tmp/users.htpasswd":source => "puppet:///san/admin/users.htpasswd",}}
#node default {file { "/tmp/cwh":mode => "440",source => "puppet:///san/admin/cwh",backup => ".bak",}}
#import "nodes/agent.mingchao.com.pp"
node default { include truth::enforcer }
#node default { notify {"I am running on node $fqdn":} }


class systeminit::firewall::config {
  resources { "firewall":purge => true}
  firewall { '0001':
  ensure     => 'present',
  action     => 'accept',
  iniface    => 'lo',
  proto      => 'all',
}
  firewall { '0002 accept ESTABLISHED RELATED':
  ensure     => 'present',
  action     => 'accept',
  isfragment => 'false',
  proto      => 'all',
  state      => ['ESTABLISHED', 'RELATED'],
}
  firewall { '0003 accept for private network':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '192.168.11.0/24',
}
  firewall { '0004 accept for 125.90.88.48':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '125.90.88.48/32',
}
  firewall { '0005 accept for private network':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '113.107.160.72/32',
}
  firewall { '0006 accept for private network':
  ensure     => 'present',
  action     => 'accept',
  proto      => 'all',
  source     => '219.129.216.215/32',
}
  firewall { '0007 accept commom rule':
  ensure     => 'present',
  action     => 'accept',
  dport      => ['80','443','843','4369','8000-8300','9000-9300','11000-15000','80','20000-30000'],
  proto      => 'tcp',
}
  firewall { '0008 accept for SSH':
  ensure     => 'present',
  action     => 'accept',
  dport      => ['61618'],
  proto      => 'tcp',
}
  firewall { '0009 accept ping':
  ensure     => 'present',
  action     => 'accept',
  icmp       => '8',
  proto      => 'icmp',
}  

}
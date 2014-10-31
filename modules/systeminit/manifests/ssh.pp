class systeminit::ssh::config {
  class { 'ssh':
    manage_firewall               => true,
    sshd_config_port              => '61618',
    sshd_password_authentication  => 'no',
    sshd_config_use_dns           => 'no',
    hiera_merge                   => true,
    sshd_config_loglevel          => 'VERBOSE',
    }
  
  define ssh_user(){
    ssh_authorized_key { $name:
      user   => 'root',
      type   => 'ssh-rsa',
      ensure => 'present',
      key    => $key,
    }
  }

  @ssh_user{ "linzhangquan@mc":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRYlS30o1g09kRn+Nm1XErfFHlSu/kh+VnQMk2+1ogl8VXEcBpB3Jc3kAh/LxKASA1iLAe4wSoCW90L5b2Qr4lXux6rVggibiLQOVrWEml9nlK+ok+YSbggxKd45SXIKI1qLOtehs9eezYwdCJ2cMCCTkb2t0QVlmPqsTZ+H8LImVfzpAd4WWlWypxNS8+AXY7/c9cGaRo29PQ8Lwe/McR1Bw+bq/vtHJavcEBH6MhTiHS4huR7tbOPqev+c7FRxdGFdxsEtkIs6mVEAW1U3et167nMFglBphyYjTkNhOa38B7/bm2T1K56iYm5SCdACHKyVNGJeIBg8O2nHPwkxMn",
  }
  @ssh_user{ "caiwenhao@mc":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqVkglLmJket+NbXy0vtsWUc5vcuMyS7xgkiml9qodleWmfi2kTwTUTstrrDHEdobQ0U251vFTZMM9Y9tlRVftfpgp4UIBKelHe+ZnzW6GifiFU9VOqyaEOGWHN0WLyWacxocNZrWvIZ1430qV95QTMkzqpRTtuySexSysL5oO08gQCT7h4MjwOwo1nm438VJXbFg7l1T8L6gUD1ZJDgwZz3+NGZ3eszZm4jssDFWsWSaOPrvoYJ6pUtH51FdnwcblMvvrKvXKbE1VMuIce2GrYAjHZs7dAG+i6w5H2HYwXrNySqZd8azkDtfY8/xispP85SwR5uH1VIQcDuLVkQ4h",
  }
  @ssh_user{ "fuqihuan@mc":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/McfwUyaRG9nUX+qzSX6cc7xAK1AxjUaXRPNulqrWSNUv3BOqyNb45UCKr0hM122VvLiFBYeXIBuzgxDVou3q5xe/g0qWlT1+edQsRGYHaMPmdTPXUr7tz07ruVU2Wo83Zron8H9PHZ7nKpncfppHtt/P2hWuOOxjfiDGRvwWSi3Z1dFiS/16ircyv4HtzF5azKroyREl6HRzWAcXz6kW9L5sMNfE1RdXzwBBINdifVXWZAsQquufbysUoghV5Uwf9Rjw7iHhmVho/dMVK22jSs1z2n3OUNh8Atb6sWEzbFTa9TYDyIZraxvaJgOt7+ldKXAe77PC4qDcEaVbEMNh",
  }
   @ssh_user{ "wangchuntao@mc":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC10BZBVWIQMrG6kAzm8TG0GkYkmayO/188g8r1rY0j6xiut8ovhIwlEyzxw9jMGyNjSLYNdFSHloY06DOs5rZt8Pe8v4jPw/NV8/igWmcan4mCIJIoPgfMjk09eJYvoYOsjuY366wIRuWF9w25FFeaJ48M+1RRGTfluFOn0zpVlD/Yf5Uh5/iail8GUWD7oWNV1eIKrjTpdO70fcEwSzBOfC7qf+cJh0Fu+lGI1/KrSaRPqjxiNO5hHcark/wBkTNsKiEMZVjz6BZ3d4vOq/Ak9O++zbJpI0qzNK0DAoqcDJi2PrrA82dSVfrh/1i7Js1kh9ZCsyIPaiAups+Jqq/f",
  }
   @ssh_user{ "liuling@MC":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCugmxeGwIZk85wSx6jYryvDzlP1+G9RpErfowefSO+p1I2gEnTKd7iYxUQhMQJGmuUs2eUQTTtFU2TRSWsVuGff3cvQxooMoaTZfX1hdcyUOpXSSLcCxc+Asf3Zn3+kZKwnYqxE2DFevZ5ObPiBD7x8cyMc5gDW9kfnrMsnQGEAdeIzxXn5uQQCrxD82CefooA7BBaCTZTZ+bbbAsZndedo9MoAkX+CwogROPhmeV4suUZNz+kL7NOhnwIFX6lCOTQE9myV19ZShHQcvv9tMUHSdBfBsovvH4xdcUtamnLn0wzuefG48iSIKvujrg127USwm1cCxrVkTkoRsrAPR3/",
  }
   @ssh_user{ "xiezhigang@mc":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVkQJ0F0fTLWEA++uXuxf7s5nDYemb8im7rHvqomS8MypjxCSIhsGEFOBstr6cPCfAxLdGmJod8gkMdzOqBv1BgX0XVJvMcAJFM8ku1VdfKK2/extKoXdS6XLiCpt65s8I3jxSNyYr+9eDBst0+Wzj009mKl6fNOW13bkKkNOMuHAkZ2mVe5ucbR0DnD96led9P7ywSgvoH/zTgtj5GbmKXtfSo0cP8ztE5Mav0dKS4scT/wpqqebQm0KgRgz1g/1qtpVftEvTngQqEndaSS5XZ+JAZ5nm35SUZhJOsXJ7W80PsLZY37yaRka/2+TFq8feHtudcg3OaQ82oicRQeNv",
  }
   @ssh_user{ "zhengheng@mc":
    key => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSkthqedx0+aXP1WjGJnODVSgVIQ0FIwBaSPEOlQiylxgcqbKJfK328FOVM+qDcmVA2hGHEPd/muINQf1kV70Mhfk+OS0/nDTL3fCTUN0tVyrjS+rJ1NrG6+uZwcK5DdMqMXmfavjOaYsiIMELroWAec+sf583O66NPJGlJXbeEMGw/yRnsc7BwS08luZYH2Pm0g4LkJ7XfDcqnBNC/hxkvRcIk5sm6x/yDIt8223oSRIhpjDacN9o4DHAbnUDgNLVojlScrxSMcXTxhn1BjgRuagYsx6z1hji2F+Cmsh3IEZnik9XCmQ9iTjLiiXH98T37gIGdtL8yxrnSDrrzVP/",
  }
  search Systeminit::Ssh::Config
  realize( Ssh_user["linzhangquan@mc"],
  	       Ssh_user["caiwenhao@mc"] )

  #修改密码
  $root_pw = inline_template("<%= ipaddress + 'mingchao' %>")
  user { "root":password => sha1(md5($root_pw))}
   
}
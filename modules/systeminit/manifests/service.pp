class systeminit::service::config {

  define del_service () {
   service { $name:
   	 enable => false,
   	 ensure => stopped,
   }

   define add_service () {
   service { $name:
   	 enable => true,
   	 ensure => running,
   }
   $other_service = inline_template("<%= `chkconfig --list |awk '{print $1}' |egrep -v 'crond|iptables|irqbalance|kdump|network|ntpd|sshd|syslog|sysstat|lvm2-monitor|atd'|xargs` %>")
   del_service{split($other_service):[ :]}
   add_service{["crond","iptables","irqbalance","kdump","network","ntpd","sshd","syslog","sysstat","lvm2-monitor","atd"]:} 


 }
}
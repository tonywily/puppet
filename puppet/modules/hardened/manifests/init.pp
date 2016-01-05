class hardened {
 file  {
   '/etc/sysconfig/iptables':
     source => 'puppet:///modules/hardened/iptables',
     owner   => root,
     group   => root,
     mode    => 644,
     notify => Exec ['reload iptables'];
 }

 service { 'iptables':
    ensure => true,
    enable => true,
    require => Package ['iptables'];
  }
  package { 'iptables':
    ensure => present,
    require => File ['/etc/sysconfig/iptables'],
  }

 exec {
    'reload iptables':
      command => '/etc/init.d/iptables restart',
      refreshonly => true,
      require => Service ['iptables'];
  }



 service { 'sshd':
    ensure => true,
    enable => true,
  }

 file  {
   '/etc/ssh/sshd_config':
     source => 'puppet:///modules/hardened/sshd_config',
     owner   => root,
     group   => root,
     mode    => 444,
     require => Service['sshd'],
     notify => Exec ['reload sshd'];
 }
 exec {
    'reload sshd':
      command => '/etc/init.d/sshd restart',
      refreshonly => true,
      require => Service ['sshd'];
 }
 file  {
   '/etc/sysctl.conf':
     source => 'puppet:///modules/hardened/sysctl.conf',
     owner   => root,
     group   => root,
     mode    => 644,
     notify => Exec ['reload sysctl'];
 }
 exec {
    'reload sysctl':
      command => '/sbin/sysctl -e -p',
      refreshonly => true,
 }


}

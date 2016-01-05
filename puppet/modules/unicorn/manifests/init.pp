class unicorn {
  require nginx
  require nginx::params
 package{
    'ruby':
      ensure => present;
    'ruby-devel':
      ensure => present;
    'git':
      ensure => present;
    'gcc':
      ensure => present;
    'rubygems':
      ensure => present;
    'bundle':
      ensure => present,
      provider => gem,
      require => Package ['rubygems'];
    'io-console':
      ensure => present,
      provider => gem,
      require => Package ['rubygems'];
    'unicorn':
      ensure => present,
      provider => gem,
      require => [Package ['rubygems'], Package['io-console'], Package ['gcc'], Package['bundle'], Package['ruby-devel']] ;
  }
   file {
    '/var/www/':
      ensure => directory,
      mode => 0755,
      owner => 'nginx',
      group => 'web';
  }
}

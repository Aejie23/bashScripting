class puppet{

  	include ::wget
	timezone => 'PHT',
	
	$pack = ['vim','curl','git']
  		package { $pack: ensure => 'installed' }

	user { 'monitor':
		ensure	=> 'present',
		home	=> '/home/monitor',
		shell	=> '/bin/bash',}

	exec { 'mkdir':
    	command => 'mkdir /home/monitor/scripts/memory_check',
	path    => '/usr/local/bin/:/bin/',}
	
    		wget::fetch { 'https://raw.githubusercontent.com/Aejie23/bashScripting/master/memory_check.sh':
    		destination => '/home/monitor/scripts/memory_check',
    		timeout     => 15,
    		verbose     => true,}
	
	file { '/home/monitor/src/':
    	ensure	=> 'directory',}

	file { 'my_memory_check':
    	path	=> '/home/monitor/src/'
	ensure	=> 'link',
	target	=> '/home/monitor/scripts/memory_check'}

	cron { 'my_memory_check':
  	command => '/home/monitor/src/my_memory_check',
  	user    => 'monitor',
  	hour    => 0,
  	minute  => 10,}
}


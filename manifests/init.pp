# == Class: ssh
#
# Full description of class ssh here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'ssh':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class ssh (
	$port = [22],
	$syslog_facility = "AUTH",
	$log_level = "INFO",
	$permit_root_login = "no",
)
{

  include ssh::params
  
	package { "openssh-server":
		ensure => "installed",
	}

	file { "/etc/ssh/sshd_config" :
		content => template('ssh/sshd_config.erb'),
#		source => "puppet:///modules/ssh/sshd_config",
		require => Package["openssh-server"],			
	}

	service { $ssh::params::ssh_svc :
		ensure => "running",
		enable => "true",
		subscribe => File['/etc/ssh/sshd_config'],
	}

}




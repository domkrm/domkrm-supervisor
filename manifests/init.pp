# @summary
# This class installs Supervisor.
#
class supervisor {

  # Install Supervisor package
  package { 'supervisor': }

  # Purge programs
  file { '/etc/supervisor/conf.d':
    ensure  => directory,
    purge   => true,
    recurse => true,
    notify  => Exec['supervisor-update'],
    require => Package['supervisor']
  }

  # Enable and start service
  service { 'supervisor':
    ensure  => running,
    enable  => true,
    require => Package['supervisor']
  }

  # Command for update configuration
  exec { 'supervisor-update':
    command     => 'supervisorctl reread & supervisorctl update',
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    refreshonly => true,
    require     => Service['supervisor']
  }

}

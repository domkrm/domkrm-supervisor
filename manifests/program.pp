# @summary
# This adds a new programm to Supervisor.
#
define supervisor::program (

  String $command,
  Boolean $autostart = true,
  Boolean $autorestart = true,
  Integer $numprocs = 1,
  String $user = 'root'

) {

  # Install Supervisor
  include supervisor

  # Add configuration file for program
  file { "/etc/supervisor/conf.d/${name}.conf":
    content => template('supervisor/program.conf.erb'),
    notify  => Exec['supervisor-update'],
    require => Package['supervisor']
  }

  # Ensure program is running
  service { "supervisor-${name}":
    ensure   => running,
    path     => '/bin:/usr/bin:/sbin:/usr/sbin',
    provider => base,
    start    => "supervisorctl start ${name}:*",
    status   => "supervisorctl status ${name}:* | grep -cv 'RUNNING' | grep '^0$'",
    require  => File["/etc/supervisor/conf.d/${name}.conf"]
  }

}

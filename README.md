Supervisor module for Puppet
============================

Module for Supervisor installation and configuration.

This module is currently tested only on Ubuntu.
But it should work on Debian (and maybe other systems) also.

Usage
-----

```puppet
supervisor::program { 'worker':
  command     => 'php worker.php',  (required)
  autostart   => true,              (default)
  autorestart => true,              (default)
  numprocs    => 1,                 (default)
  user        => 'root'             (default)
}
```

Installation
------------

As soon as you create a program the Supervisor package will be installed.

Purge
-----

This module purges all programs which are not managed by puppet.
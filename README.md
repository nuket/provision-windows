provision-windows
=================

A batch file to provision a Windows machine in a virtual machine.

It strips down the automatically-started services to the bare minimum and removes certain autostarts (Java Updater, specifically).

It's certainly not as powerful as Puppet or Chef, but it's light enough to free up some resources.

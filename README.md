provision-windows
=================

A batch file to provision a Windows machine in a virtual machine. At the moment, this is focusing on Windows XP.

It strips down the automatically-started services to the bare minimum and removes certain autostarts (Java Updater, specifically).

It's certainly not as powerful as Puppet or Chef, but it's still light enough to free up some resources. The idea is to run as lightweight of a VM as possible, which means as few background services and eye-candy as possible.

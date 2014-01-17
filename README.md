provision-windows
=================

tl;dr
-----

On a completely fresh system, open up a Command Line window and use `explorer.exe` to pull down `provision.bat`:

    `explorer.exe provision.bat`

What is this?
-------------

A batch file and registry file to provision Windows XP as a virtual machine guest. At the moment, it focuses on Windows XP, obtaining a memory footprint of a mere 128MB after boot. The only ports which are open (and, in any case, blocked by the firewall) are 135 and 139. 

It strips down the automatically-started services to the bare minimum and removes certain autostarts (Java Updater, specifically).

It's certainly not as powerful as Puppet or Chef, but it's still light enough to free up some resources. The idea is to run as lightweight of a VM as possible, which means as few background services and eye-candy as possible.

provision-windows
=================

tl;dr
-----

On a completely fresh system, open up a Command Prompt and use `explorer.exe` to pull down the provisioning files:

    explorer http://git.io/-ggbHQ
    
Save this in a folder, unpack it, and then run `provision.bat`. Make sure to save the Git and Python downloads to the same folder containing `provision.bat`. 

What is this?
-------------

A batch file and registry file to provision Windows XP as a virtual machine guest. At the moment, it focuses on Windows XP, obtaining a memory footprint of a mere 128MB after boot. The only ports which are open (and, in any case, blocked by the firewall) are 135 and 139. 

It strips down the automatically-started services to the bare minimum and removes certain autostarts (Java Updater, specifically).

It sets the console to Lucida Console, 150x50, with 3000 scrollback lines.

It installs Git, which brings a bunch of Unix-style commands with it, most importantly including `curl`, which can be used for further simple software downloads.

It installs Python, easy_install, pip, and virtualenv, and sets the PATH to make these available to all accounts.

It's certainly not as powerful as Puppet or Chef, but it's still light enough to free up some resources. The idea is to run as lightweight of a VM as possible, which means as few background services and eye-candy as possible.

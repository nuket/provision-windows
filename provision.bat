@echo off

echo ---------------------------------------------------------------------
echo Disable unnecessary services
echo,
echo http://www.blackviper.com/windows-services/
echo,
echo ALG: We're not worrying about using Internet Connection Sharing.
echo,
echo AudioSrv: We don't need audio alerts or audio at all.
echo,
echo ERSvc: We don't need to send error reports to Microsoft.
echo,
echo helpsvc: A waste of resources even on a normal desktop.
echo,
echo JavaQuickStarterService: Uses RAM to preload Java base classes.
echo,
echo LanmanServer: Get rid of the Server service.
echo,
echo LmHosts: NetBIOS Helper
echo,
echo Nla: Network Location Awareness (NLA): Never was clear what this does.
echo,
echo ShellHWDetection: Probably not plugging a lot of devices into a VM.
echo,
echo srservice: System Restore Service isn't necessary when Windows is 
echo            in a VM. Snapshot the VM from the outside.
echo,
echo TrkWks: Distributed Link Tracking Client was never clear what benefit
echo         this /ever/ provided besides wasting RAM on millions of computers.
echo,
echo W32Time / Windows Time service is disabled as time is synchronized to
echo virtual machine host's clock
echo,
echo wscsvc: Windows Security Center - I think I've got a handle on it.
echo ---------------------------------------------------------------------
echo,

for %%S in (ALG, AudioSrv, ERSvc, helpsvc, JavaQuickStarterService, LanmanServer, LmHosts, Nla, PolicyAgent, ProtectedStorage, RemoteRegistry, Schedule, ShellHWDetection, Spooler, srservice, SSDPSRV, Themes, TrkWks, W32Time, wscsvc) do (
  echo sc config %%S start= disabled
  sc config %%S start= disabled
  
  echo sc stop %%S
  sc stop %%S
)

echo ---------------------------------------------------------------------
echo Enable essential services
echo,
echo BITS is required for Windows Update to work 
echo (though as of April 2014, that's not going to matter anymore)
echo,
echo EventSystem: required for SENS
echo,
echo Dnscache
echo,
echo SENS: System Event Notification Service (poweroffs, etc.)
echo,
echo wuauserv: Windows Update service
echo ---------------------------------------------------------------------
echo,

for %%S in (BITS, EventSystem, Dnscache, SENS, wuauserv) do (
  echo sc config %%S start= demand
  sc config %%S start= demand
  
  echo sc start %%S
  sc start %%S
)

echo ---------------------------------------------------------------------
echo Terminate Java Update Scheduler (Good grief, Oracle!)
echo ---------------------------------------------------------------------
echo,

taskkill /f /im jusched.exe

echo ---------------------------------------------------------------------
echo Remove Java Update Scheduler run at startup from Registry
echo ---------------------------------------------------------------------
echo,

regedit /s provision.reg

echo ---------------------------------------------------------------------
echo Set Time Zone
echo,
echo https://stackoverflow.com/questions/14943431/set-time-zone-on-windows-xp
echo http://www.pcreview.co.uk/forums/select-time-zone-timedate-cpl-batch-command-t3943860.html
echo,
echo On XP, you can provide one of the strings in Date and Time Properties / Time Zone tab
echo to the /Z parameter.
echo,
echo Or look in the registry for usable Time Zone Names:
echo HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones
echo,
echo NOTE: Do NOT type quotes around the Time Zone Name.
echo ---------------------------------------------------------------------
echo,

runDLL32.exe shell32.dll,Control_RunDLL timedate.cpl,,/Z W. Europe Standard Time

echo ---------------------------------------------------------------------
echo Windows Time Service settings are disabled, since this is provisioning
echo a virtual machine that is synced regularly to the host's clock.
echo ---------------------------------------------------------------------
echo,
echo ---------------------------------------------------------------------
echo Update Windows Time service settings
echo,
echo "Windows Time Service Tools and Settings"
echo http://technet.microsoft.com/en-us/library/cc773263(v=ws.10).aspx
echo ---------------------------------------------------------------------
echo,

rem w32tm /config /manualpeerlist:"0.de.pool.ntp.org time.windows.com time.nist.gov" /update



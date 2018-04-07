# cloudshell-lcd
ODROID-XU4 Cloudshell Server LCD Informations

## How this software works
### Files
#### cloudshell-lcd
The master script for pre-configuring the system for and printing to the LCD screen.
##### helper/config
Control parameters.
##### helper/functions
Abstracting functionality away from the main script to improve legibility.
#### raid/checkRAID.bash
A nice wrapper around the output of `raidmgr_static` to produce a useful output to `cloudshell-lcd`. This runs every 5 minutes to check the state of the RAID setup, and updates `/var/log/RAID_STATUS4LCD` with text representing what to display in `cloudshell-lcd`, which checks this file and renders the text to the display on each refresh.
#### raid/raidmgr_static (JMS56X HW RAID Manager V8.0.0.1)
This is the low-level diagnostics tool used by `checkRAID.bash` to assess the actual state of the drives.


## To Do
* Pass all Shellchecker tests
* Debug inevitable bugs from `danger coding` the hell out of this implementation
* Add systemd service to run checkRAID.bash every 5 minutes; replace cron

```
# /etc/systemd/system/minute-timer.timer

[Unit]
Description=Minute Timer

[Timer]
OnBootSec=5min
OnCalendar=*:0/1
Unit=minute-timer.target

[Install]
WantedBy=basic.target
```

```
# /etc/systemd/system/minute-timer.target

[Unit]
Description=Minute Timer Target
StopWhenUnneeded=yes
```
```
# /etc/systemd/system/testservice.service

[Unit]
Description=Prints the date every minute
Wants=minute-timer.timer

[Service]
ExecStart=/bin/date

[Install]
WantedBy=minute-timer.target
```
* Host package on an apt repo for easy install (similar to `add-apt-repository ppa:kyle1117/ppa`)
    * Check that package metadata roughly resembles that of `cloudshell-lcd` on this repo - does it depend on odroid-cloudshell?
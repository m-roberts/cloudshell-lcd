# cloudshell-lcd
ODROID-XU4 Cloudshell Server LCD Informations

## Installation
```
wget https://github.com/m-roberts/cloudshell-lcd/blob/master/cloudshell-lcd.deb
sudo dpkg -i cloudshell-lcd.deb
```

## How this script works
### Files
#### cloudshell-lcd
The master script for pre-configuring the system for and printing to the LCD screen.
##### helper/config
Control parameters.
##### helper/functions
Abstracting functionality away from the main script to improve legibility.
#### raid/checkRAID.bash
This runs every 5 minutes to check the state of the RAID setup, and updates a file accordingly. `cloudshell-lcd` checks this file on each refresh
#### raid/raidmgr_static (JMS56X HW RAID Manager V8.0.0.1)
Not really sure right now...


## To Do
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
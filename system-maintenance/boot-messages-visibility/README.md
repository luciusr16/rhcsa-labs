
# Enabling Visible Boot Messages

## Overview
Visible boot messages are essential for troubleshooting system startup issues and understanding what processes are loaded during boot. So in this lab I configured the system to ensure all boot messages are visible. 

You can perform this doing two valid methods: using the grubby tool or editing the GRUB configuration manually.

## step by step process: 
### Method 1: Using grubby
Enable Boot Messages (Removes the  rhgb quiet):
```
grubby --update-kernel=ALL --remove-args="rhgb quiet"
```
### Verify Changes
```bash
grubby --info=ALL | grep args
```
### Reboot the System
```bash 
reboot
```
Upon reboot, you will see detailed boot messages on the screen.






### Method 2: Manual GRUB Configuration Edit
Edit GRUB Configuration File
```bash 
vim /etc/default/grub
```
### Modify the GRUB_CMDLINE_LINUX Line: Remove rhgb quiet:
```bash  
GRUB_CMDLINE_LINUX=""
```
### Save and Exit, Then Update GRUB:
```bash 
grub2-mkconfig -o /boot/grub2/grub.cfgreboot
```

### notes 
Using grubby is safer and avoids manual errors, especially when managing multiple kernels. 
Always verify changes and ensure boot functionality before making further configurations.

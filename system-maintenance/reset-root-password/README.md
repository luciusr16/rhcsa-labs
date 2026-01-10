
# RHEL 9 Resetting the root password 

## Overview
In this lab I reset the root password on an alma Linux system by interrupting the boot process and using the emergency shell.

this method will be used if you have lost or forgotten the root password and cannot log in. You will be able to recover the system without reinstalling the OS. 

## step by step process: 

### initiate a reboot to access the grub menu
```bash
reboot
```
### enter grub menu 
```bash
    At the GRUB 2 boot menu, highlight the default boot option.

    Press e to edit the boot parameters.

    Find the line starting with linux and add rd.break to the end of this line to enter emergency mode.

    Press Ctrl+X to boot with these modified parameters.
```
### remount the root filesystem as writable
```bash
    mount -o remount,rw /sysroot
```
### enter the Chroot Environment
```bash 
chroot /sysroot
```
### reset the Root Password
```bash 
passwd root
```
### enable SELinux relabeling:
```bash  
    To ensure the SELinux contexts are correctly applied on reboot, create the /.autorelabel file:

touch /.autorelabel
```
### exit chroot and reboot 
```bash 
exit
reboot
```

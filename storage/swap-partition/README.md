# Configure a 500Mib swap partition 

## Overview
In this lab I created a swap partition that activates at startup which involved configuring the partition, formatting it as swap, and adding it to the /etc/fstab file for automatic mounting. 

## Commands (Step by Step)

 Step 1: Check Current Memory and Swap Usage:
```bash
free -m  
```
Step 2: Open the fdisk utility and create the partition 
```bash 

fdisk /dev/sdb

n - Create a new partition

p - Select a primary partition

Press Enter to confirm the default first sector

Enter +500M for the last sector size

t - Change the partition type

Type 82 for Linux Swap

p - Print the partition table to verify

w - Write changes to disk and exit fdisk
```
Step 3: Format the New Partition as Swap:
```bash
mkswap /dev/sdb1

swapon /dev/sdb1 
```
Step 4: Add Swap Partition to /etc/fstab for Automatic Activation:

(you can ge the UUID by running the command - blkid /dev/sdb1)  
```bash 
echo "UUID=<UUID of /dev/sdb1>     swap  swap  defaults 0  0"  >> /etc/fstab 
```
Step 5: Verify Everything
```bash
lsblk

free -m

swapon
```

### notes 
Swap space acts as overflow memory when RAM is fully utilized. 

Having it set up to auto-activate at boot ensures the system can handle memory demands consistently.






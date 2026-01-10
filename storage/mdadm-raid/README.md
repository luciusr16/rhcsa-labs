# Configure RAID 1 Using mdadm 

## Overview
In this lab, I configured a **software RAID 1 (mirroring)** array on a Red Hat Enterprise Linux 9 system using `mdadm`.
RAID 1 provides disk redundancy by mirroring dataacross multiple disks, allowing the system to continue operating if one disk fails.

---

## Objectives
- Install the mdadm utility
- Create a RAID 1 array using two disks
- Format and mount the RAID device
- Configure persistence across reboots
- Verify RAID status and health

---

## Environment
- Operating System:AlmaLinux 9
- RAID tool: mdadm
- Disks used: `/dev/sdb`, `/dev/sdc` (unused disks)
- RAID device: `/dev/md0`
- Mount point: `/mnt/raid1`


## Commands (Step by Step)

 Step 1: Install mdadm
```bash
sudo dnf install -y mdadm
```
Step 2: Verify available disks
```bash 
lsblk
```
Step 3: Create the RAID 1 array
```bash
sudo mdadm --create --verbose /dev/md0 \
  --level=1 \
  --raid-devices=2 \
  /dev/sdb /dev/sdc
```
Step 4: Create a filesystem on the RAID device
```bash 
sudo mkfs.ext4 /dev/md0
```
Step 5: Create mount point and mount the RAID array
```bash
sudo mkdir /mnt/raid1
sudo mount /dev/md0 /mnt/raid1
```
Step 6: Save RAID configuration
```bash
sudo mdadm --detail --scan >> /etc/mdadm.conf
```
Step 7: Configure persistent mount
```bash
blkid /dev/md0

sudo vim /etc/fstab

UUID=<md0_UUID>  /mnt/raid1  ext4  defaults  0 0

sudo mount -a
```
## notes and lessons learnt 
- Software RAID using `mdadm` is still relevant for boot disks, virtual machines, and environments without hardware RAID.
- RAID 1 provides redundancy by mirroring data but does **not** increase usable storage capacity.
- A RAID device behaves like a normal block device once created and must be formatted and mounted like any other disk.


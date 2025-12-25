# RHEL 9 Stratis Storage Lab

## Overview

In this lab I configured a stratis storage on my alma linux machine. 
Stratis is a modern storage management solution that simplifies disk pooling and filesystem management by combining device-mapper, thin provisioning, and XFS with a daemon-managed interface.

Here I created a Stratis storage pool using a dedicated disk and mounted it persistently so it survives system reboots.

---

## Objectives

- Install and enable Stratis on RHEL 9
- Create a Stratis storage pool using a raw block device
- Create a filesystem within the Stratis pool
- Mount the filesystem at `/stratis`
- Configure persistent mounting using `/etc/fstab` with systemd awareness
- Verify correct operation after configuration

---

## Environment

- Operating System: Alma Linux 
- Storage Device: `/dev/sdc` (unused disk)
- Mount Point: `/stratis`

---
## Commands step by step 
Step 1: Install Stratis Packages
```bash
sudo dnf install -y stratis-cli stratisd
```

Step 2: Enable and Start the Stratis Daemon.
```bash 
sudo systemctl enable --now stratisd

systemctl status stratisd
```
Step 3: Create a Stratis Storage Pool
```bash
sudo stratis pool create strat_pool /dev/sdc
```
verify the pool:
```bash 
stratis pool list
```
Step 4: Create a Stratis Filesystem
```bash
sudo stratis filesystem create strat_pool strat_fs
```
verify the filesystem 
```bash
stratis filesystem list
```
Step 5: Create the Mount Point
```bash
sudo mkdir /stratis
```
Step 6: Mount the Filesystem Temporarily (Validation check)
```bash
sudo mount /dev/stratis/strat_pool/strat_fs /stratis
```
verify it 
```bash
df -h | grep stratis
```
Step 7: Configure Persistent Mounting (Retrieve the filesystem UUID)
```bash
stratis filesystem list
```
add this line to  /etc/fstab for persistent mounting
```bash
UUID=<filesystem_UUID>  /stratis  xfs  defaults,x-systemd.requires=stratisd.service  0 0
```
the UUID will ensure stable device identification 
and x-systemd.requires=stratisd.service ensures the Stratis daemon is available before mounting at boot and prevents boot-time mount failures

Step 8: Apply and Verify Persistent Configuration
```bash
sudo mount -a

df -h | grep stratis
```
## notes and lessons learnt 
stratis abstracts complex storage management behind safe defaults

Thin provisioning allows flexible filesystem growth without the risk of deleting and resizing partitions.

systemd integration is critical for reliable boot-time mounting

Stratis is well-suited for modern RHEL environments where simplicity and safety are priorities

Stratis is a  safe choice within a companies infastructure because not all linux admins are skilled at configuring storage, and one wrong mistake can be fatal. 











# Local DNF/YUM Repository Setup (RHEL / AlmaLinux 9)

## Overview
This repository documents how to configure a **local DNF/YUM repository** using a RHEL-compatible 9.x ISO image (RHEL, AlmaLinux, Rocky Linux).

This setup is commonly used in:
- Offline or air-gapped environments
- Exam environments (RHCSA/RHCE)
- Controlled lab systems without internet access

---

## Objectives
Configure the system so that **DNF installs packages only from a locally mounted ISO**, using the `BaseOS` and `AppStream` repositories.


---

## Environment
- OS:  AlmaLinux 9 
- Package Manager: `dnf`
- ISO lives  at: `/opt/alma.iso`
- Mount point is: `/mnt/local`
- Repository files located in: `/etc/yum.repos.d/`

## Commands (Step by Step)

Step 1: Mount the ISO Image
```bash
mount -o loop /opt/alma.iso  /mnt/local
```
Verify the mount, you should see BaseOS and Appstream
```bash 
ls /mnt/local 
```
Step 2: Disable All Existing Repositories
```bash
dnf config-manager --set-disabled '*'

dnf repolist --enabled
```
Step 3: Create the Local Repository File
```bash
cd /etc/yum.repos.d

touch local-baseos.repo  ;  touch local-appstream.repo
```
add content here in each of the files you created. 
```bash

[local-baseos]
name=Local BaseOS
gpgcheck=0
enabled=1
baseurl=file:///mnt/local/BaseOS/

[local-appstream]
name=Local AppStream
gpgcheck=0
enabled=1
baseurl=file:///mnt/local/AppStream/
```
Step 4: Clean DNF Cache and verify repo configs
```bash
dnf clean all

dnf repolist 
```
Step 5: Test Package Installation
```bash
dnf install -y vim
```
Step 6: Configure persistent mount for the repo
```bash
vi /etc/fstab
```
add this line to the /etc/fstab file 
```
/opt/alma.iso  /mnt/local  iso9660  loop   0   0
```
then back out using :wq! and use the command below to test the mount
```bash 
sudo mount -a
```
## notes and lessons learnt 
A repository does **not** require internet access.  
Any directory containing valid `repodata/` can be used as a DNF source.
DNF treats local repositories the same as remote ones by using the `file:///` URL scheme.
BaseOS and AppStream must be defined as **separate repositories** for proper package resolution on RHEL 9–based systems.

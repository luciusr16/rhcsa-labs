# autofs – Syncing Home Directories across servers 

## Goal
Automount user home directories from an NFS server under /remote-home directory on another server

## environment 
- ServerA (NFS server)
- ServerB (NFS client)

 Step 1: Setup nfs server on server A 
```bash
sudo dnf install nfs-utils
sudo systemctl enable --now nfs-server
```
Step 2:  add the second line to the file to export all home directories
```bash 
vi /etc/exports
/home    *(rw,sync,no_root_squash)
```
backout of the file and run this command
```bash
exportfs -rav 
```
Configure firewall rules: 
```bash
firewall-cmd --add-service=nfs --permanent
firewall-cmd --reload
firewall-cmd --list-all
```
Step 3: configure autofs and nfs on server b client
```bash
sudo dnf install autofs nfs-utils  -y
systemctl enable --now auotfs
```
Step 4: Create a mountpoint 
```bash
mkdir /remote-home
```
Step 5: Configure autofs 
```bash
vi /etc/auto.master
```
 go to the bottom of this file and add the line
```bash
/remote-home  /etc/auto.home  --timeout=60  
```
Step 6: create the config file and tell auotfs where to mount from
```bash
touch /etc/auto.home
```
add this line to the file 
```bash
*     -fstype,nfs,rw,sync   nfs-server-ip:/home/&
```
now restart autofs 
```bash
systemctl restart autofs
```
Step 7: test the auto mount 
```bash
cd /remote-home/testuser 
```

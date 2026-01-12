# NFS Server and Client Auto-Mount Lab

## Goal

This lab documents the setup of an **NFS server** and a **client system**
configured to automatically mount a shared directory at boot.

The objective is to simulate a real-world centralized storage scenario
commonly used for home directories, shared data, and application storage.

 Step 1: Install NFS Utilities
```bash
sudo dnf install nfs-utils
sudo systemctl enable --now nfs-server
```
Step 2:  Create Shared Directory
```bash 
mkdir -p /shared
chmod 755 /shared
```
Step 3: Configure NFS Exports

add this line to /etc/exports
```bash
/shared *(rw,sync,no_root_squash)
```
back out of the file and apply the exports: 
```bash
exportfs -rav
```
Step 4: NFS CLIENT SIDE CONFIGURATION NOW: 

first download the NFS utilities
```bash
dnf install -y nfs-utils
```
Step 5: Create mountpoint 
```bash
mkdir -p /mnt/shared
```
Step 6: Configure Automatic Mount (Persistent)

Edit /etc/fstab:
```bash
nfs-server:/shared  /mnt/shared  nfs  defaults,_netdev  0  0
```
mount all entries
```bash
mount -a
```
Step 7: Verify everything
```bash
df -h
mount | grep nfs
```

## notes  
NFS enables centralized file sharing across Linux systems

/etc/exports controls what directories are shared and how

exportfs applies NFS export rules without rebooting

_netdev in the /etc/fstab line prevents boot failures if the network is unavailable

/etc/fstab enables automatic mounting at startup

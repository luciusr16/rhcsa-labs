# LVM Partitioning

This lab documents hands-on Logical Volume Manager (LVM) partitioning tasks.
The goal is to practice real administrative storage workflows 

---

##  Scenario
- Create an LVM physical volume
- Create a volume group
- Create a logical volume
- Format it with ext4
- Mount it persistently
- Extend the logical volume online without downtime

---

## Commands Used

## Create Physical Volume
```bash
pvcreate /dev/sdb1 
```
## create volume group  
```bash
vgcreate vgdata /dev/sdb1 
```
## create logical volume group 
```bash
lvcreate -L 1G -n lvfiles vgdata 
```
## create ext4 filesystem 
```bash 
mkfs.ext4 /dev/vgdata/lvfiles
```
## mount logical volume
```bash
mkdir /data
mount /dev/vgdata/lvfiles /data
```
## option to mount persistently too 
```bash
echo '/dev/vgdata/lvfiles /data ext4 defaults 0 0' >> /etc/fstab
```
## Extend Logical Volume (Online)
```bash
lvextend -r -L +500M /dev/vgdata/lvfiles
```
## verify all
```bash
lsblk
df -h /data
vgs
lvs
```

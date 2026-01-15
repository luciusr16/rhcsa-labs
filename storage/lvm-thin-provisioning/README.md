# LVM Thin Provisioning 

Thin provisioning lets you create a logical volume with a virtual size while only consuming actual physical space as data is written.

---

##  Scenario
I will be using **/dev/sdb** to complete the following:

1. Create a **4G Volume Group** named `myvg`
2. Create a **2G thin pool** named `mythinpool` inside `myvg`
3. Create a **5T thin-provisioned volume** named `mythinvol` inside `mythinpool`
4. Extend `mythinpool` by **+1G**
5. Rename thin pool `mythinpool` = `thinpool1`
6. Rename thin volume `mythinvol` = `thinvol1`

---

## Commands Used

## Partition /dev/sdb for LVM (4G)
```bash
fdisk /dev/sdb
-------------------

n (new)

p (primary)

choose a partition number 

accept default first sector - press enter

+4G - for last sector

w (write)
```
## Create PV + VG (myvg)
```bash
pvcreate /dev/sdb3
vgcreate myvg /dev/sdb3
```
verify it
```bash
pvs
vgs
```
## Create 2G Thin Pool (mythinpool)
```bash
lvcreate -L 2G --thinpool myvg/mythinpool
```
verify everything:
```bash
lvs -a
```
## Create 5T Thin Volume (mythinvol)

Creating a thin LV with a 5T virtual size inside the thin pool:
```bash 
lvcreate -V 5T -T myvg/mythinpool -n mythinvol
```
verify everything:
```bash
lvs -a
```
## Extend the Thin Pool by +1G
```bash
lvextend -L +1G myvg/mythinpool
```
verify:  
```bash
lvs -a 
```
## Rename the Thin Pool from mythinpool = thinpool1
```bash
lvrename myvg/mythinpool myvg/thinpool1
```
## Rename the Thin Volume from mythinvol = thinvol1
```bash
lvrename myvg/mythinvol myvg/thinvol1
```
verify both the thin pool and thin volume have been renamed:
```bash
lvs -a
```
## check final block layout 
```bash
lsblk
```
## notes
.thin provisioning allows volumes to appear large while only using disk space when data is written

.storage is allocated from a shared thin pool, improving overall disk efficiency.

.commonly used in virtualisation and cloud environments to avoid over-allocating storage.

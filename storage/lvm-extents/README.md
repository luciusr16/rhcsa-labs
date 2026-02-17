```bash 

#here i use /dev/sdb to create and LVM partition with 50 extents and 1 extent equal to 16M

# first check block devices and make partition  
lsblk 

fdisk /dev/sdb 

# p: Print the current partition table.
#n: Start creating a new partition.
# for the last sector option allocate 816M, as 16 x 50 = 816 
# w:  Write the table to disk and exit fdisk.


# Initialize /dev/sdb1 as an LVM Physical Volume 
pvcreate /dev/sdb2

pvs

# Create a Volume Group (VG) named myvg with 16 MiB extent size

 vgcreate -s 16M myvg /dev/sdb1

# verify VG creation 

vgdisplay myvg
vgs 

# create the logical volume named mylv  with 50 extents 
lvcreate -l 50 -n mylv myvg

# verify creation

lvs 

```



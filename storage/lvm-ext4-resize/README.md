# LVM + ext4 Resize Lab (RHEL 9)

## Goal
Extend an existing ext4 filesystem using LVM without data loss.

## Environment
- OS: RHEL 9
- Disk: /dev/sdb
- Volume Group: vg_data
- Logical Volume: lv_data
- Mount point: /data
- 
  Notes
- Logical volume must be extended before resizing the filesystem
- `resize2fs` supports online resizing for ext4

1. Checked current disk and LV state:
```bash
lsblk

df -h

lvextend -L +5G /dev/vg_data/lv_data

resize2fs /dev/vg_data/lv_data

df -h


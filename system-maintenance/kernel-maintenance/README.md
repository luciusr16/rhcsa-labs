# Kernel Update and Boot Management Lab (RHEL 9)

## Here I safely updated the Linux kernel on a RHEL 9 system while ensuring:

The new kernel becomes the default on reboot

The original kernel remains installed and bootable

The system retains a fallback recovery option

```bash
# STEP 1  - update all system packages
sudo dnf update -y


# STEP  2 - update the kernel only package
# this wil install the latest supported kernel
sudo dnf update kernel -y


# STEP 3 - verify installed kernel versions
# multiple kernel versions will be listed.
rpm -q  kernel


# STEP 4-  confirm the default boot kernel
# in rhel 9 the newest kernel will be set by default
grubby --default-kernel 

# STEP 5 - then reboot the system
# this is required to activate the new kernel
sudo reboot


# STEP 6- verify the running  kernel after reboot
uname -r


# KERNEL ROLLBACK AND MANAGEMENT
# list all available boot kernels
grubby --info=ALL | grep kernel

# you can manually set a specific kernel as default
sudo grub2-set-default <index>



```

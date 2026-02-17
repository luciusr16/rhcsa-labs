```bash 

# here i configured apache to access NFS-mounted directories 

# at first selinux was blocking apache from accessing NFS.

# so in order to grant access i changed this boolean: 

setsebool -P httpd_use_nfs 1 

# setsebool will modify selinux policies, -P will make it persistent after reboot  
# httpd_use_nfs 1 - will set the boolean to enabled 

# then verify it 
getsebool httpd_use_nfs

# you should see an output of httpd_use_nfs --> on




```

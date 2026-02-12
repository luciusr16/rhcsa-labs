```bash 

# I changed a new directory selinux context to /etc context 


step 1  - create your directory 
mkdir -p /mydirectory 

step 2 - verify selinux context of /etc directory 
ls -dZ /etc 
#  Using ls -dZ displays the SELinux context of /etc without listing its contents.


step 3 - apply the context  to your dir 
semanage fcontext -a -t etc_t "/mydirectory/.*)?"

# we use a regular expression here to ensure all files and directories within your directory get matched.

# now recursively apply the selinux context 
restorecon -Rv /mydirectory 

#  The restorecon command restores the SELinux labels based on defined policies.




```

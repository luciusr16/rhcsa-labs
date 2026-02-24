```bash 

# i configured my system to use the YUM repos on another server on my local network 

# i ensured these repos were set as default  

----------------------------------------------------------------------------
# verify the repos URLs 

curl http://192.168.1.190/dvd/BaseOS
curl http://192.168.1.190/dvd/AppStream


# disbale all current repos with either commands 
mv /etc/yum.repos.d/*.repo /tmp/

dnf config-manager --set-disabled "*" 



# create the custom repo config file 

vim /etc/yum.repos.d/rhel9.repo

# add this content below : 


    [LocalRepo_BaseOS]
    name=LocalRepo_BaseOS
    enabled=1
    gpgcheck=0
    baseurl=http://192.168.1.190/dvd/BaseOS/
     
    [LocalRepo_AppStream]
    name=LocalRepo_AppStream
    enabled=1
    gpgcheck=0
    baseurl=http://192.168.1.190/dvd/AppStream/



# enabled=1 will ensure that these repos are enabled by default 
# gpgcheck=0 will disable gpg signature checking 



# now back out with :wq! 
# and set correct permissions: 
chmod 644 /etc/yum.repos.d/rhel9.repo 



# now clean and list 

dnf clean all 
dnf repolist 

# now we can confirm the repo functionality 
dnf update 




```

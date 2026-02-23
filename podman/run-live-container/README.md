```bash


# Configured  persistent storage at
/var/lib/containers/backup_storage

# Mount it as /mnt inside a UBI container

# Create a file sample.txt from inside the container

# Stop and remove the container

# Verify persistence on the host


# STEP 1 - verify selinux status 
getenforce 

# you should see Enforcing 



# STEP 2 - create persistent storage directory 
mkdir -p /var/lib/containers/backup_storage
ls -ld /var/lib/containers/backup_storage



STEP 3 - run the container  
podman run --name ubi-backup \
  --privileged \
  -it \
  -v /var/lib/containers/backup_storage:/mnt:z \
  registry.redhat.io/ubi8/ubi \
  /bin/bash





STEP 4  - create file inside container 
echo "The container volume is /mnt" > /mnt/sample.txt
ls -l /mnt
cat /mnt/sample.txt

# now exit the container  

exit


STEP 5 - verify file on host 
cat /var/lib/containers/backup_storage/sample.txt

# you should see  : The container volume is /mnt

 



STEP 6 - cleanup 

# list containers 
podman ps -a 

# stop and remove container 
podman stop  ubi-backup  
podman rm ubi-backup  

# confirm removal 
podman ps -a 


```

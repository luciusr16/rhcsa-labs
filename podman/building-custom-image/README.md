```bash
# in this lab i built an image from a containerfile 

# it displays "are you ready" when ran

# i used a redhat universal base image8




# STEP 1 -  Set Up the environment 
mkdir ~/Are_You_Ready
cd ~/Are_You_Ready


# STEP 2 - create the container file 
vim Containerfile

# add these lines to the file 
    
FROM registry.access.redhat.com/ubi8/ubi

COPY are_you_ready /usr/local/bin

ENTRYPOINT ["/usr/local/bin/are_you_ready"]


# STEP 3 - create the script 
vim are_you_ready 

#!/bin/bash 

echo "are you ready?"

# set script permissions 
chmod 755 are_you_ready 



# STEP 4 - prepare to start the container 

# build the container image  
podman build -t are_you_ready . 

# verify the image 
pdoman images 

# now run the container  

podman run --name are_you_ready_run  are_you_ready 

# now verify the container 

podman ps -a 


```

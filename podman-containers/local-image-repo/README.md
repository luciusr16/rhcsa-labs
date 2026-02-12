```bash
# in this lab i set up a local image repo 
# in the location /var/lib/registry port 5000 
# and pushed the httpd container image to the image repo 


# step 1 - setup environment 
sudo dnf install container-tools -y 

mkdir -p /var/lib/registry 

# step 2 - run the container 

 podman run --privileged -d --name registry -p 5000:5000 -v /var/lib/registry:/var/lib/registry:Z registry 

# --privileged grants the container full access to host 


step 3-  configrue podman to recognize local reg 

vi /etc/containers/registries.conf


[[registry]]
location="localhost:5000"
insecure=true

# location="localhost:5000": Sets the local registry's address.

# insecure=true: Allows unencrypted connections, suitable for local testing.


step 4 - Push the httpd Image to the Local Registry


podman search httpd --filter=is-official 

# --filter=is-official limits results to official images, helping you select verified sources.

 podman pull docker.io/library/httpd

# pull latest httpd image and tag it 
 podman tag docker.io/library/httpd localhost:5000/httpd

# Tagging prepares the image for the local repository. Here, localhost:5000 designates the registry location.

# now finally push httpd image 
podman push localhost:5000/httpd

# This command uploads the image to your local registry, making it available for others to pull.



# step 5 - VERIFY 

ls -l /var/lib/registry/docker/registry/v2/repositories/




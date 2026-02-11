```bash
#  Deploying a Local Container Registry with Podman

#  GOALS of this lab
# to deploy a local container image registry at  /var/lib/registry
# expose the registry on port 5000
# push the httpd image to the local repo


# step  1 - install tools
sudo dnf  instal container-tools -y

# verify the install 
podman --version

# step 2  - create registry storage directory
mkdir -p /var/lib/registry

step 3 -  run the local registry container
podman run --privileged -d \
  --name registry \
  -p 5000:5000 \
  -v /var/lib/registry:/var/lib/registry:Z \
  registry

step 4 - configure local insecure registry
vi /etc/containers/registries.conf

# add this
# this will allow http communication without tls security for local testing

[[registry]]
location="localhost:5000"
insecure=true

step 5 - pull and tag the httpd image

podman pull docker.io/library/httpd

podman tag docker.io/library/httpd localhost:5000/httpd


step 6-  push image to local registry and confirm image exists
podman push localhost:5000/httpd
ls -l /var/lib/registry/docker/registry/v2/repositories/
# you should see the httpd image in here

# lastly confirm the registry is running
podman ps
ss -tulnp | grep 5000




```

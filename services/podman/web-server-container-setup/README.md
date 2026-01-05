# Rootless Apache Container with Podman 


## Objective
Deploy a persistent, rootless Apache HTTP container managed by systemd user service using Podman.

The container serves web content from a host directory, survives reboot, and runs without root privileges.


 Step 1: pull and tag the image
```bash
podman pull registry.access.redhat.com/ubi9/httpd-24
podman tag registry.access.redhat.com/ubi9/httpd-24 httpd-24
```
confirm the image
```bash
podman images
```
Step 2:  created the mountpoint with a .html file 
```bash 
mkdir -p ~/www-data
echo "hello world" > ~/www-data/index.html
```
Step 3: run the rootless container with podman 
```bash
podman run -d \
  --name httpd \
  -p 127.0.0.1:8080:8080 \
  -v ~/www-data:/var/www/html:Z \
   localhost/httpd-24
```
CREATING SYSTEMD PERSISTNECE 

(before this enable lingering to ensure services remain running after reboot.)
```bash
loginctl enable-linger $(whoami)
loginctl show-user $(whoami)
```
Step 4: generate user unit 
```bash
mkdir -p ~/.config/systemd/user
podman generate systemd --files --name httpd  --new 
mv container-httpd.service ~/.config/systemd/user/
systemctl --user daemon-reload
```
now enable and start the service 
```bash
systemctl --user enable --now container-httpd.service
```
Step 5: verfiy everything 
```bash
podman ps
systemctl --user status container-httpd.service
curl http://localhost:8080
```
you should now see "hello world" that we put in the  index.html file



# WordPress Deployment with Podman


## Overview 
This lab demonstrates how to deploy a WordPress container using Podman

It covers container installation, persistent storage with SELinux, port mapping, firewall configuration, and validation.

The container is run in detached mode, exposes HTTP on port 80, and uses a private SELinux bind mount for persistence.

Commands used: 
--------------
## Step 1: Install container-tools
```bash
dnf install -y container-tools
```
The container-tools package installs core container utilities on RHEL 9, including:

podman – container runtime

skopeo – remote image inspection and transfer

buildah – image building tool

These tools replace Docker in Red Hat–based systems.

## Step 2: Search for the official wordpress image
```bash 
podman search wordpress -f is-official
```
## Step 3: Pull the wordpress image
```bash
podman pull docker.io/library/wordpress
```
## Step 4: Create persistent storage directory
```bash
mkdir -p /home/wordpress/var/www/html
```
## Step 5: Run the container 
```bash
podman run -d \
  --name mywordpress \
  -p 80:80 \
  -v /home/wordpress/var/www/html:/var/www/html:Z \
  docker.io/library/wordpress
```
the "--name mywordpress" will assign a predictable container name. 
-p 80:80 will maps the container port 80 to the host on port 80.
the "-v....:Z"  will bind mount persistent storage with private SElinux labeling. 
-d - will run the container in detached mode.  
## Step 6: verify container status 
```bash
podman ps -a
```
## Step 7: configure the firewall for HTTP and veirfy it 
```bash
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
firewall-cmd --list-all
```
## Step 8 : Test the application in browser or cli 
```bash
CLI TEST=  curl http://localhost:80 
BROWSER TEST=  http://127.0.0.1:80

The WordPress setup page confirms successful deployment.
```


## notes and lessons learnt: 
I got an error message saying that I could not the run the container due to the port 80 being used elsewhere. so I had to stop the apache service the re run the container on port 80.  

the reason i searched for the official wordpress image was to ensure tight security. As non official container images can pose a  supply-chain and configuration risk.

Without correct SELinux labeling, the container will be denied access to the mounted directory.The :Z bind-mount option relabels host files with a private SELinux context, allowing access only to that container.



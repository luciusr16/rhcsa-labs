
# Rootless Apache Container with Podman 


## Overview 
This lab demonstrates how to run a Redis container as a rootless systemd service using Podman Quadlet on RHEL 9.2+.

Quadlet provides a declarative, systemd-native way to manage containers and is now the preferred standard over imperative podman generate systemd workflows.

The result is a secure, persistent, reboot-safe Redis service running entirely in user space, with SELinux enforcing enabled.


## Step 1: Prepare the Environment
```bash
sudo dnf install -y podman skopeo

podman pull docker.io/library/redis
podman tag docker.io/library/redis localhost/myredis

mkdir -p ~/redis-data
```
## Step 2: Configure System Prerequisites

Enable lingering for the user

This allows user systemd services to start at boot without an active login session.
```bash 
sudo loginctl enable-linger $(whoami)
```
Configure SELinux (persistent) 

This resolves SELinux denials related to rootless container cgroup management while keeping SELinux in Enforcing mode.
```bash
sudo setsebool -P container_manage_cgroup on
```
## Step 3: Create the Quadlet Container Definition

Ensure Quadlet directory exists
```bash
mkdir -p ~/.config/containers/systemd/
```
Create the Quadlet file
```bash
cat <<EOF > ~/.config/containers/systemd/redis.container
[Unit]
Description=Redis Quadlet Container

[Container]
ContainerName=redis
Image=localhost/myredis
PublishPort=6379:6379
Volume=/home/username-directory/redis-data:/data:Z

[Service]
Restart=always

[Install]
WantedBy=default.target
EOF
```
## Step 4: Start and Verify the Service
```bash
systemctl --user daemon-reload

systemctl --user start redis

systemctl --user status redis --no-pager

podman ps | grep redis

```

## notes and lessons 
.SELinux is not an enemy and can remain fully enforcing with correct configuration

.Quadlet is the modern standard for containerized services on RHEL

.Rootless containers significantly reduce attack surface

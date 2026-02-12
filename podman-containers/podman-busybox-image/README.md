# Podman & Image Management Lab (BusyBox)


## Overview 
This lab demonstrates basic container image inspection, image management, and container lifecycle operations using Podman and Skopeo on a RHEL 9 system.

## Goals of the lab
The goal is to validate understanding of:

Container tooling installation

Remote image inspection

Image tagging

Running and removing containers

## Objectives  
Install container tooling

Inspect a container image without pulling it

Pull and tag a container image

Run a container in detached mode

Clean up container resources


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

## Step 2:  Inspect the BusyBox Image with skopeo
```bash 
skopeo inspect docker://docker.io/library/busybox
```
skopeo inspect retrieves metadata from a remote registry without pulling the image.
this is good for security reviews and compatibility checks before downloading an image.  

## Step 3: Pull the BusyBox Image Using podman and verify it 
```bash
podman pull docker.io/library/busybox
podman images
```
this will download the latest busybox image from docker hub to the system. 
busybox is a minimal linux image used for testing and lightweight containers.

## Step 4: Tag the Image as mybusybox
```bash
podman tag docker.io/library/busybox mybusybox
```
image tagging creates another reference to the same image, which is helpful for image management and scripting. 

## Step 5: Run the Container in Detached Mode and confirm it 
```bash
podman run -d --name busybox mybusybox
podman ps -a 
```
the "-d" will run the container in the background and the "--name busybox" is the name for the container. 
I create the container from the local image we tagged earlier - mybusybox 

## notes and lessons learnt: 
skopeo inspect allows image analysis without dowloading

image tags are just references not copies 

podman has the ability to manage containers either rootlessly or as root. 

# RHEL 9 Stratis Storage Lab

## Overview

- in this lab I will be going over how to configure network settings on a network interface. 

---

## Objectives

- configure all network interface settings. 

---

## Environment
- Operating System: AlmaLinux

---

## Commands (Step by Step)

### first find the network interface you would like to edit  
```bash
nmcli device show 
```
### step 2:  to add an ipv4 address
```bash
nmcli con mod enp0s3 +ipv4.addresses 192.168.1.161/24 
```
### step 3:  add an ipv4 default gateway 
```bash 
nmcli con mod enp0s3 +ipv4.gateway 192.168.1.1  
```



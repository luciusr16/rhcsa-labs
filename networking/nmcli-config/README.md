# RHEL 9 Stratis Storage Lab

## Overview
In this lab, I configured a network interface with a static IPv4 address using `nmcli`,
the command-line tool for managing NetworkManager on RHEL 9 / AlmaLinux 9 systems.

- This approach is commonly used on servers where predictable network configuration is required, such as application servers, databases, and internal infrastructure systems.
---

## Objectives
- To identify active network interfaces 
- Configure a static IPv4 address using nmcli
- Set gateway and DNS servers
- Apply and verify the network configuration
- Ensure changes persist across reboots
---

## Environment
- Operating System: AlmaLinux / RHEL 9
- Network tool: NetworkManager (nmcli)
- Interface: `enp0s3`
- IP Address: `192.168.1.50/24`
- Gateway: `192.168.1.1`
- DNS: `8.8.8.8`
---

## Commands (Step by Step)

### Step 1: Verify NetworkManager is running
```bash
systemctl status NetworkManager

```
### Step 2: Identify available network interfaces
```bash
nmcli device status
```
### Step 3: View existing connection profiles 
```bash
nmcli connection show 
```
### Step 4: Configure a static IPv4 address
```bash 
sudo nmcli connection modify enp0s3 \
ipv4.method manual \
ipv4.addresses 192.168.1.50/24 \
ipv4.gateway 192.168.1.1 \
ipv4.dns 8.8.8.8
```
### Step 5: Bring the connection down and back up
```bash 
sudo nmcli connection down enp0s3 
sudo nmcli connection up enp0s3
```
### Step 6: Verify the new network configurations
```bash  
ip addr show enp0s3

ip route

cat /etc/resolv.conf

ping -c 4 8.8.8.8

ping -c 4 google.com
```
### notes and lesson learnt 
nmcli is the preferred tool for managing networking on RHEL-based systems

Static IP configuration is common for servers and infrastructure nodes

Restarting the connection is required for changes to take effect

NetworkManager ensures persistence across reboots by default

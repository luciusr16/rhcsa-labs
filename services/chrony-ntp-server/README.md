# Chrony (NTP) Server Setup Lab (

## Goal

This lab demonstrates how to configure a Chrony time server to provide accurate and reliable network time synchronization to client systems.

Chrony is the default and recommended NTP implementation on modern RHEL-based systems and is critical for:

authentication systems (Kerberos, LDAP)

logging and auditing accuracy

distributed systems

security incident correlation

certificate validation



 ## Step 1: Configure the Chrony Server (ServerA)
```bash
sudo dnf install -y chrony
```
## Step 2: Configure Chrony server settings

Edit the configuration file:
```bash 
# Use public NTP servers
server 0.pool.ntp.org iburst
server 1.pool.ntp.org iburst
server 2.pool.ntp.org iburst

# Allow clients from the local network
allow 192.168.1.0/24

# Record the rate at which the system clock gains/loses time
driftfile /var/lib/chrony/drift

# Enable logging
logdir /var/log/chrony

# Step the clock on large offset at startup
makestep 1.0 3
```
## Step 3: Enable and start Chrony
```bash
sudo systemctl enable --now chronyd
systemctl status chronyd
```
## Step 4:  Configure the firewall

Allow NTP traffic:
```bash
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload
```
## Step 5: Verify server synchronization

this will show us the upstream sources that are reachable. it will also how us if the system clock is synchornized.
```bash
chronyc sources -v
chronyc tracking
```
## Step 6: Configure the Chrony Client (ServerB)

Install Chrony 
```bash
sudo dnf install -y chrony
```
## Step 7: Configure the client to use ServerA
```bash
sudo vi /etc/chrony.conf

# replace any existing servers in this file with the below:
server ServerA iburst

# now start chrony on the client
sudo systemctl enable --now chronyd

# verify the client synchronization
chronyc sources -v
chronyc tracking

# ensure server A is listed as the time sources and the offset and skew are kept to a minimum.
```

## notes  

chrony will operate not problem while SElinux is in enforcing mode by default. so no selinux booleans or contexts have to be changed. 

in the chrony config file ensure that the allow parameter is set to only internal trusted networks. 



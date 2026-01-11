# SSH server setup 

## Goal
the goal of this lab was to setup an ssh server on an alma linux machine and then secure it with passwordless login using keys instead.  


 Step 1: download the required packages
```bash
sudo dnf install openssh-server -y 
```
Step 2:  start and enable the service  
```bash 
systemctl enable --now sshd
systemctl status sshd 
```
Step 3: configure firewall rules
```bash
firewall-cmd --add-service=ssh --permanent
firewall-cmd --add-port=22/tcp 
firewall-cmd --reload
fireawal-cmd --list-all
```
Step 4: edit config file to only allow passwordless logins 
```bash
vi /etc/ssh/sshd_config
```
change this line to "no" 
```bash
PasswordAuthentication no 
```
Step 5: configure a user for passwordless logins using ssh-keys instead 
```bash
ssh-keygen
ssh-copy-id testuser@testserver
```
there is a hidden directory for the users ssh keys, where you will see the one you just created 
```bash
cd /home/testuser/.ssh
```
Step 6: verify you can login with no password 
```bash
ssh testuser@testserver
```
## notes 
If you want to change any other parameters for the ssh server, the config file is located in the directory-  /etc/ssg/sshd_config 

The reason passwordless login is appied in production is to allow admins to more effeciently remotely connect to a machine.  

It can also prevent brute force attacks to gain access to users accounts on systems 

It is also a good idea to disable root login for ssh access, because if an attacker gets in via root they will have privilleged access on the system.

It is always good to give users sudo access so you can track changes to the system via logs. 




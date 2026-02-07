
# Secure File Transfer Between Servers

## Goal
this is how to securely transfer a sensitive system file between two Red Hat Enterprise Linux (RHEL) 9 servers using modern, encrypted file transfer methods.

here i focus on confidentiality, integrity, and best practices, using SSH-based tools rather than legacy or insecure protocols.

the scenatio is that - a user samir needs to securely transfer the  /etc/hosts file on server A to his directory on server B.   


## Step 1: Configure SSH Key-Based Authentication
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```
### Copy the public key to ServerB
```bash
ssh-copy-id samir@ServerB
```
## Step 2: Secure File Transfer Methods
### Option 1: SFTP (Secure File Transfer Protocol)
```bash 
sftp samir@ServerB
sftp> put /etc/hosts /home/samir_dir/
sftp> exit
```
### Option 2: Rsync Over SSH (Recommended for Admins)
```bash
rsync -e ssh /etc/hosts samir@ServerB:/home/samir_dir/
```
Enhanced transfer with logging and compression
```bash
rsync -avz -e ssh /etc/hosts samir@ServerB:/home/samir_dir/
```





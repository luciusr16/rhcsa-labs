# Shared Collaboration Directory - SGID Group Ownership

## Goal
This lab demonstrates how to configure a shared directory so that all files and subdirectories created within it automatically inherit a specific group ownership and prevent accidental deletion. 

This setup is commonly used for team collaboration on multi-user Linux systems.

## comamnds step by step 
 Step 1: create the group and users if not already 
```bash
groupadd developers
```
Step 2:  create the directory 
```bash 
mkdir /developers  
```
Step 3: set group ownership and enable SGID and a sticky bit on the directory 
```bash
chgrp developers /developers
chmod g+s /developers
chmod +t /developers
```
Step 4: verify the changes 
```bash
ls -ld /developers 
```
Step 5: create and add your users 
```bash
useradd -m -s /bin/bash dev1 ; useradd -m -s /bin/bash dev2 
passwd dev1
passwd dev2 
usermod -aG developers dev1 ; usermod -aG developers dev2 
```
now switch to that user and create a testfile 
```bash
su - dev1
touch /developers/testfile-dev1 
ls -l /developers
```
You should now see the file group ownership is developers, not the users primary group. This is due to the SGID. 

Now test that users in the same group cannot delete others files.
```bash
su - dev2
rm -rf /developers/testfile-dev1
```
You will find that dev2 user will not be able to delete the dev1 users file. This is due to the sticky bit we set on the directory earlier.
```

## notes
linux files are owned by a user and a group 

SGID on a directory forces group inheritance for new files

SGID is essential for shared directories in multi-user environments

Prevents permission issues in collaborative workflows


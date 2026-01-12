# ACL permissions lab 

## Goal

This lab demonstrates how to use Access Control Lists to grant fine-grained permissions beyond traditional owner/group/other mode bits.

ACLs are used when multiple users need different access levels to the
same directory or files.  

---
## Lab Scenario

- Create a shared directory `/collaboration`
- Base group ownership is `managers`
- User `alice` needs **read/write** access
- User `bob` needs **read-only** access
- All new files should **inherit ACL permissions**

---
### Create Group and Users (if not present)
```bash
groupadd managers
useradd alice
useradd bob
usermod -aG managers alice
usermod -aG managers bob
```

 Step 1: Create the Shared Directory
```bash
mkdir /collaboration
chgrp managers /collaboration
chmod g+s /collaboration
chmod +t /collaboration
```
Step 2: Set ACL permissions

Grant Read/Write Access to alice
```bash 
setfacl -m u:alice:rw- /collaboration
```
Grant Read-Only Access to bob
```bash
setfacl -m u:bob:r-- /collaboration
```
Step 3: Set Default ACLs (Inheritance)
```bash
setfacl -d -m u:alice:rw- /collaboration
setfacl -d -m u:bob:r-- /collaboration
```
Step 4:  Verification

View ACLs
```bash
user:alice:rw-
user:bob:r--
default:user:alice:rw-
default:user:bob:r--
```
Step 5: Functional testing phase

As alice:
```bash
su - alice
touch /collaboration/alice_file
echo "test" >> /collaboration/alice_file
```
As Bob: 
```bash
su - bob
cat /collaboration/alice_file
echo "fail" >> /collaboration/alice_file
```
As expected Bob can read but he cannot write. 

As for Alice she can do both read and write.  

These actions are reflective of the ACL permissions set.

## notes 
ACLs are ideal for shared environments with mixed access needs

ACLs extend standard Unix permissions

ACLs coexist with standard permissions, they do not replace them

The filesystem must support ACLs (default on ext4/xfs)

Use ACLs sparingly to avoid complex permission models

# Account & Password Management (chage, login.defs, pwquality)

## Overview
Implement and verify secure local account and password policies on RHEL using:
- `chage` (per-user aging and expiry)
- `/etc/login.defs` (system-wide defaults)
- `/etc/security/pwquality.conf` (password complexity)

This lab demonstrates real administrative controls, verification, and safe change practices.

---

## Commands (Step by Step)

### Create test accounts (baseline)
```bash
sudo groupadd security
sudo useradd -m -s /bin/bash -G security acct_user
sudo passwd acct_user
```
verify
```
id acct_user
getent passwd acct_user
```
### Per-user password aging with chage
```bash
sudo chage -l acct_user
```
Apply policy:

Max days: 90

Min days: 7

Warn: 14

Inactive after expiry: 7
```bash
sudo chage -M 90 -m 7 -W 14 -I 7 acct_user
sudo chage -l acct_user
```
Force password change at next login:
```bash
sudo chage -d 0 acct_user
sudo chage -l acct_user
```
Set and remove account expiry:
```bash
sudo chage -E 2026-03-01 acct_user
sudo chage -l acct_user

sudo chage -E -1 acct_user
```
### System-wide defaults with /etc/login.defs
(this will only apply to new users that are added not existing ones.)

backup the file: 
```bash
sudo cp -a /etc/login.defs /etc/login.defs.bak
```
edit the file and add this config into it: 
```bash
PASS_MAX_DAYS   90
PASS_MIN_DAYS   7
PASS_WARN_AGE   14
UID_MIN         1000
UMASK           077
```
prove effect on new users: 
```bash
sudo useradd -m defs_user
sudo passwd defs_user
sudo chage -l defs_user
```
### Password complexity with /etc/security/pwquality.conf
backup configuration: 
```bash 
sudo cp -a /etc/security/pwquality.conf /etc/security/pwquality.conf.bak
```
Edit policy and change to these parameters:  
```bash
minlen = 12
difok = 4
ucredit = -1
lcredit = -1
dcredit = -1
ocredit = -1
maxrepeat = 3
reject_username
enforce_for_root
```
Verify PAM usage:
```bash
sudo grep -R pam_pwquality -n /etc/pam.d
```
Test enforcement:
```bash
sudo passwd acct_user
```
Weak passwords should be rejected; strong passwords accepted.

### Account locking and administrative controls

Lock and unlock account:
```bash 
sudo passwd -l acct_user
sudo passwd -S acct_user

sudo passwd -u acct_user
```
Disable login shell (soft lock):
```bash
sudo usermod -s /sbin/nologin acct_user
getent passwd acct_user
```

### notes  
chage controls per-user aging and expiry

/etc/login.defs defines system defaults for new accounts

pwquality.conf enforces password strength via PAM

Always verify with command output, not assumptions

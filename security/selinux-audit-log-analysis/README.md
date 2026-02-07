
# SELinux Audit Log Analysis

## Goal
This lab demonstrates how to scan, analyze, and interpret SELinux denials using the system audit logs.

The goal is to identify security-relevant events, understand why they occurred, and produce actionable remediation steps—without disabling SELinux.

The final analysis is saved to /audit_log.txt for review and reporting.


## Step 1: Comprehensive SELinux Analysis with sealert
```bash
sudo sealert -a /var/log/audit/audit.log > /audit_log.txt
```

## Step 2: Targeted Analysis with ausearch and audit2why
```bash 
sudo ausearch -m avc -ts today | audit2why >> /audit_log.txt
```
Analyze a specific denial by event ID - example
```bash
sudo ausearch -a <event_id> -i | audit2why
sudo ausearch -a 43 -i | audit2why
```
## Step 3: Review the Results
```bash
sudo cat /audit_log.txt
```
## Step 4: Actionable Remediation Options
Generate a Custom Allow Rule (Last Resort)
```bash 
sudo ausearch -a <event_id> -i | audit2allow -M mymodule
sudo semodule -i mymodule.pp
```
Adjust SELinux Booleans (Preferred)
```bash
getsebool -a
sudo setsebool -P <boolean_name> on
restorecon -Rv /path/to/files
```

## Notes and lessons 

audit2why explains why an action was blocked, not just what was blocked.

SELinux booleans should be preferred over custom policies whenever possible.

Custom policy modules (audit2allow) should be treated as a last resort and reviewed carefully.




```bash 

# in this lab i configured my machine to only allwo http traffic from a certain IP and reject every other IP.

# i achieved this using firewall-cmd rich rules

# this is improtant for tightening up servers and security.


# STEP 1 - allow HTTP traffic from 192.168.1.12/24 network: 

firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.12/24" service name="http" accept' 


# STEP 2 - block all other HTTP traffic  

firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="0.0.0.0/0" service name="http" reject' 



# STEP 3 - RESTART AND VERIFY CHANGES 

firewall-cmd --runtime-to-permanent

firewall-cmd --zone=internal --list-all 



# NOTES: 
# Persistence with --runtime-to-permanent: Ensures rules are maintained across reboots.

# Rich Rules vs. Standard Rules: Rich rules allow precise filtering by combining multiple criteria, while standard rules provide simpler but effective configuration.







```

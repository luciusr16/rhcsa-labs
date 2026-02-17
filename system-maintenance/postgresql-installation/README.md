```bash 

# I installed postgresql 13 as the default mode 

# this shows module management and controlled version installation


# STEP 1 - list available postgresql module streams
dnf module list postgresql

# expected output 
Name        Stream   Profiles             Summary
postgresql  10       client, server       PostgreSQL server and client
postgresql  12       client, server       PostgreSQL server and client
postgresql  13       client, server [d]   PostgreSQL server and client

# this is important because rhel uses app streams to manage multiple versions of software simultaneously

# before installing, always verify:
#desired version exists and correct stream is available 



STEP 2 - enable desired version of postgresql 
dnf module enable postgresql:13 -y

# this will activate version 13 stream and set it as default version for isntallation 


STEP 3 - Verify module is enabled 

dnf module list postgresql

# look for : 
postgresql  13 [e]
# e - means enabled 


STEP 4 - finally - install postgresql 
dnf install postgresql -y

# so because we enabled the module stream this will install version 13 


STEP 5 - verify the install 

psql -V
psql --version


# expected output 

psql (PostgreSQL) 13.x


```

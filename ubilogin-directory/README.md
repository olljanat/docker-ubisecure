# ubilogin-directory
This folder contains dockerfile which will install OpenLDAP to CentOS 7 and include Ubisecure SSO schemas to it.

# Docker
## Build
```
docker build . -t ubilogin-directory
``` 

## Create service
```
mkdir /data/ubilogin-directory
docker service create --name ubilogin-directory --network ubisecure -p 389:389 --mount type=bind,source=/data/ubilogin-directory,destination=/var/lib/ldap ubilogin-directory
```

# New LDAP instance init
When you create new environment you need copy template files from container to host by running command:
```
docker cp <containerid>:/var/lib/ldap.template/ .
```
then stop container by running
```
docker service scale ubilogin-directory=0
```
Remove default files and replace them with template files:
```
rm -rf /data/ubilogin-directory/*
mv ldap.template/* /data/ubilogin-directory/
```
And restart container again
```
docker service scale ubilogin-directory=1
```

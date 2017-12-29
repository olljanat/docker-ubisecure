# ubisecure-ldap
This folder contains dockerfile which will install OpenLDAP to CentOS 7 and include Ubisecure SSO schemas to it.

# Docker
## Build
```
docker build . -t ubisecure-ldap
``` 

## Create service
```
mkdir /data/ubisecure-ldap
docker service create --name ubisecure-ldap --network ubisecure -p 389:389 --mount type=bind,source=/data/ubisecure-ldap,destination=/var/lib/ldap ubisecure-ldap
```

# New LDAP instance init
When you create new environment you need copy template files from container to host by running command:
```
docker cp <containerid>:/var/lib/ldap.template/ .
```
then stop container by running
```
docker service scale ubisecure-ldap=0
```
Remove default files and replace them with template files:
```
rm -rf /data/ubisecure-ldap/*
mv ldap.template/* /data/ubisecure-ldap/
```
And restart container again
```
docker service scale ubisecure-ldap=1
```

# ubisecure-ldap
This folder contains dockerfile which will install OpenLDAP to CentOS 7 and include Ubisecure SSO schemas to it.

# Docker
## Build
```bash
docker build . -t ubisecure-ldap
``` 

## Create service
```bash
mkdir /data/ubisecure-ldap
docker service create --name ubisecure-ldap --network ubisecure -p 389:389 --mount type=bind,source=/data/ubisecure-ldap,destination=/var/lib/openldap ubisecure-ldap
```

# TODO
* Change OpenLDAP running with ldap user
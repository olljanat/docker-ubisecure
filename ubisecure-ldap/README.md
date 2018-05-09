# ubisecure-ldap
This folder contains dockerfile which will install OpenLDAP to Alpine Linux and include Ubisecure SSO schemas to it.

# Docker
## Build
```bash
docker build . -t ubisecure-ldap
``` 

## Create services
### Master
```bash
mkdir /data/ubisecure-ldap-master
docker service create --name ubisecure_ldap-master --network name=ubisecure,alias=ldap-master --mount type=bind,source=/data/ubisecure-ldap-master,destination=/var/lib/openldap ubisecure-ldap
```

### Slave
```bash
mkdir /data/ubisecure-ldap-slave
docker service create --name ubisecure_ldap-slave --network name=ubisecure,alias=ldap-slave --mount type=bind,source=/data/ubisecure-ldap-slave,destination=/var/lib/openldap ubisecure-ldap
```

# TODO
* Change OpenLDAP running with ldap user
* Finalize master/slave config
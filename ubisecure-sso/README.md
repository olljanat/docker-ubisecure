# Ubisecure SSO
This folder contains dockerfile which will install Ubisecure SSO to Alpine Linux.

Source documentation:
https://developer.ubisecure.com/docs/display/IDS82/SSO+Cluster+Installation
https://developer.ubisecure.com/docs/display/IDS82/Ubisecure+Password+Installation

# Docker
## Build
```bash
docker build . -t ubisecure-sso
``` 

### Create service
```bash
docker service create --name ubisecure-sso --network ubisecure ubisecure-sso
```

# New LDAP instance init
When you create new environment you need import LDAP data by running these commands inside of ubisecure-sso container
```bash
cd /usr/local/ubisecure/ubilogin-sso/ubilogin
cat ldap/cnroot.ldif ldap/uas.ldif ldap/secrets.ldif ldap/system-password.ldif ldap/openldap/groups.ldif | ldap/openldap/import.sh
```

## Verify
You can connect to ubisecure-ldap example by using [LDAP Admin](http://www.ldapadmin.org) and connect to docker host IP like this:
![alt text](https://raw.githubusercontent.com/olljanat/docker-ubisecure/master/screenshots/ubisecure-ldap_connect.png "LDAP connect")
![alt text](https://raw.githubusercontent.com/olljanat/docker-ubisecure/master/screenshots/ubisecure-ldap_list.png "LDAP list")

# TODO
* Move hardcoded passwords/whole unix.config to docker secrets
* Run setup.sh on runtime instead of installation
* Configure to use redis
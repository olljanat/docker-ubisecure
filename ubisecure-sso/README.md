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

## Create docker secret from unix.config file
```bash
SECRETNAME='ubisecure-sso-'`date --utc +%Y%m%d%H%M%S`
echo $DATAPROTECTION | docker secret create $SECRETNAME ./unix.config
```

## Create service
```bash
docker service create --name ubisecure_sso --network name=ubisecure,alias=sso --secret source=$SECRETNAME,target=/usr/local/ubisecure/ubilogin-sso/ubilogin/unix.config ubisecure-sso
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
* Configure to use redis
* Figure out where to get mail.jar

# Workarounds
Currently you need copy ubilogin-sso\java\linux-x64\jre\lib\ext\mail.jar file from SSO 8.1.x media to ubisecure-sso\jre-lib other why password application cannot doesn't start.
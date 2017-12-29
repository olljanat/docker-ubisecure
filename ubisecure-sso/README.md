# Ubisecure SSO
This folder contains dockerfile which will install Ubisecure SSO to CentOS 7.

Source documentation:
https://developer.ubisecure.com/docs/display/IDS82/SSO+Cluster+Installation

# Docker
##Build
```
docker build . -t ubisecure-sso
``` 

### Create service
```
docker service create --name ubisecure-sso --network ubisecure --replicas=1 ubisecure-sso
```

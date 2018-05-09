# docker-ubisecure
This repository contains script and dockerfiles to dockerize Ubisecure SSO and CustomerID applications.

Design principles on these have been:
* Use as much existing official docker images as possible.
* Minimize amount of Ubisecure customizations as much as possible.
* Only one role per containers.
* Make containers as generic as possible.
* TODO: High availability configuration is used for everything
* TODO: Security by default...

I hope that some day Ubisecure will include these scripts to part of their build process and start provide pre-created docker images for their customers.

# Usage
Download https://demo.ubisecure.com/extranet/downloads/SSO/8.2/sso-8.2.24-unix.tar.gz to ubisecure-sso and ubisecure-ldap folders

Follow readme files on folders


# Start whole stack on Docker Swarm
```bash
export UBISECURE_LDAP_VERSION=v1
export UBISECURE_SSO_VERSION=v1
docker stack deploy --compose-file ./docker-compose.yml ubisecure
```


# Picture
![alt text](https://raw.githubusercontent.com/olljanat/docker-ubisecure/master/screenshots/ubisecure_on_docker.png "Ubisecure on docker")
# ubisecure-syslog
This folder contains syslog-ng config which can be used with ubisecure-sso.

# Docker

## Create service
```bash
mkdir /data/ubisecure-syslog
docker service create --name ubisecure-syslog --network ubisecure --mount type=bind,source=/data/ubisecure-syslog,destination=/logs balabit/syslog-ng
```

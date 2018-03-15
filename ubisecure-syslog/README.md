# ubisecure-syslog
This folder contains syslog-ng config which can be used with ubisecure-sso.

# Docker

## Create service
```bash
mkdir /data/ubisecure-syslog
mkdir /data/ubisecure-syslog/conf
cp syslog-ng.conf /data/ubisecure-syslog/conf/

mkdir /data/ubisecure-syslog/logs
docker service create --name ubisecure-syslog --network ubisecure --mount type=bind,source=/data/ubisecure-syslog/conf/syslog-ng.conf,destination=/etc/syslog-ng/syslog-ng.conf --mount type=bind,source=/data/ubisecure-syslog/logs,destination=/logs balabit/syslog-ng
```

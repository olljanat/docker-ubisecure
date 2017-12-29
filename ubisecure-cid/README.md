# Ubisecure CustomerID
This folder contains dockerfile which will install Ubisecure CustomerID to CentOS 7.

Source documentation:
https://developer.ubisecure.com/docs/display/IDS82/ubisecure-cid+Two+Node+Installation

# Docker
## SQL
Create docker service with persistent data for Customer ID PostgreSQL
```
mkdir /data/ubisecure-sql
echo "ChangeMe123!" | docker secret create ubisecure-sql-postgres-pwd -
docker service create --name ubisecure-sql --network ubisecure -p 5432:5432 --secret ubisecure-sql-postgres-pwd -e POSTGRES_PASSWORD_FILE=/run/secrets/ubisecure-sql-postgres-pwd --mount type=bind,source=/data/ubisecure-sql,destination=/var/lib/postgresql/data postgres:9.4
```

## CustomerID
### Build
```
docker build . -t ubisecure-cid
``` 

### Create service
```
docker service create --name ubisecure-cid-master --network ubisecure --replicas=1 ubisecure-cid
```

# Setup
Login to container:
``` 
docker exec -it <containerid> bash
``` 

Run DB init script (change customerd_user password to same than you use one linux.config):
```
/root/init-cid-db.sh '+hn%4=xJ^aGPpjgt'
```
and give postgres user (admin user) password when script asks it.


## CustomerID Two Node JDBC Data Source Creation On Linux
```
cd /usr/local/ubisecure/customerid/tools
./config-wildfly-domain-datasource.sh
```

## Setting Up Audit and Diagnostic Logging
```
cd /usr/local/ubisecure/customerid/tools
./config-wildfly-domain-logging.sh
```
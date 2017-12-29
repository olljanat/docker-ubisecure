#!/bin/bash
if [ -z "$1" ]
then
	echo "Usage: ./init-cid-db.sh <customerid_user_password>"
else
	set -e

	psql -v ON_ERROR_STOP=1 --username "postgres" --host "ubisecure-sql" <<-EOSQL
	CREATE USER customerid_user WITH PASSWORD '$1';
	CREATE DATABASE customeriddb WITH OWNER = customerid_user ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1;
	GRANT CONNECT, TEMPORARY ON DATABASE customeriddb TO public;
	GRANT ALL ON DATABASE customeriddb TO customerid_user;
	EOSQL

	export PGPASSWORD=$1
	psql -v ON_ERROR_STOP=1 --host "ubisecure-sql" --dbname="customeriddb" --username="customerid_user" -f "/usr/local/ubisecure/customerid/sql/cid_create.sql"
	psql -v ON_ERROR_STOP=1 --host "ubisecure-sql" --dbname="customeriddb" --username="customerid_user" -f "/usr/local/ubisecure/customerid/sql/cid_init.sql"
	psql -v ON_ERROR_STOP=1 --host "ubisecure-sql" --dbname="customeriddb" --username="customerid_user" -f "/usr/local/ubisecure/customerid/sql/cid_create_sso_views_and_functions.sql"
fi


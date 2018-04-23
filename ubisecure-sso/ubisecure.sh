#!/bin/bash

if [ -f /usr/local/ubisecure/ubilogin-sso/ubilogin/unix.config ]
then
	echo "Generating settings based on unix.config"
	./setup.sh

	echo "Starting tomcat"
	/usr/local/tomcat/bin/catalina.sh run
else
	echo "unix.config does not found. will shutdown..."
	exit 1
fi

FROM tomcat:8.0.48-jre8-alpine
ENV SSO_VERSION=8.2.19
ENV JRE_HOME=/usr/lib/jvm/default-jvm/jre/

RUN apk update; \
	apk add openldap-clients

COPY /sso-${SSO_VERSION}-unix.tar.gz /tmp
RUN mkdir /usr/local/ubisecure/; \
	tar -zxf /tmp/sso-${SSO_VERSION}-unix.tar.gz -C /usr/local/ubisecure/; \
	rm /tmp/sso-${SSO_VERSION}-unix.tar.gz; \
	rm -rf /usr/local/ubisecure/ubilogin-sso/tomcat; \
	ln -s /usr/local/tomcat /usr/local/ubisecure/ubilogin-sso/tomcat; \
	rm -rf /usr/local/tomcat/webapps; \
	ln -s /usr/local/ubisecure/ubilogin-sso/ubilogin/webapps /usr/local/tomcat/webapps; \
	rm -f /usr/local/ubisecure/ubilogin-sso/openldap/bin/*; \
	ln -s /usr/bin/ldapmodify /usr/local/ubisecure/ubilogin-sso/openldap/bin/ldapmodify; \
	rm -rf /usr/local/ubisecure/ubilogin-sso/template/config/tomcat
	
WORKDIR /usr/local/ubisecure/ubilogin-sso/ubilogin

COPY /unix.config /usr/local/ubisecure/ubilogin-sso/ubilogin/
RUN ./setup.sh
COPY /keystore.pfx /usr/local/ubisecure/ubilogin-sso/ubilogin/custom/tomcat/keystore.pfx
COPY /server.xml /usr/local/ubisecure/ubilogin-sso/tomcat/conf/


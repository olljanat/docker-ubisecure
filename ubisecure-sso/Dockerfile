FROM tomcat:8.0.50-jre8-alpine
ENV SSO_VERSION=8.2.24
ENV JRE_HOME=/usr/lib/jvm/default-jvm/jre/

RUN apk update; \
	apk add openldap-clients

# Workaround to get "javax.mail" classes which are needed by password feature 
COPY /jre-lib/ /usr/lib/jvm/java-1.8-openjdk/jre/lib/ext/

COPY /sso-${SSO_VERSION}-unix.tar.gz /tmp
RUN mkdir /usr/local/ubisecure/; \
	tar -zxf /tmp/sso-${SSO_VERSION}-unix.tar.gz -C /usr/local/ubisecure/; \
	chmod u+x /usr/local/ubisecure/ubilogin-sso/ubilogin/setup.sh; \
	rm /tmp/sso-${SSO_VERSION}-unix.tar.gz; \
	rm -rf /usr/local/ubisecure/ubilogin-sso/tomcat; \
	ln -s /usr/local/tomcat /usr/local/ubisecure/ubilogin-sso/tomcat; \
	rm -rf /usr/local/tomcat/webapps; \
	ln -s /usr/local/ubisecure/ubilogin-sso/ubilogin/webapps /usr/local/tomcat/webapps; \
	rm -f /usr/local/ubisecure/ubilogin-sso/openldap/bin/*; \
	ln -s /usr/bin/ldapmodify /usr/local/ubisecure/ubilogin-sso/openldap/bin/ldapmodify; \
	rm -rf /usr/local/ubisecure/ubilogin-sso/template/config/tomcat

WORKDIR /usr/local/ubisecure/ubilogin-sso/ubilogin

COPY /template/ /usr/local/ubisecure/ubilogin-sso/template/
COPY /keystore.pfx /usr/local/ubisecure/ubilogin-sso/ubilogin/custom/tomcat/keystore.pfx
COPY /tomcat-conf/ /usr/local/ubisecure/ubilogin-sso/tomcat/conf/
COPY /password/ /usr/local/ubisecure/ubilogin-sso/tomcat/webapps/password/

COPY /ubisecure.sh /usr/local/tomcat/ubisecure.sh
CMD ["sh","/usr/local/tomcat/ubisecure.sh"]
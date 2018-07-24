FROM alpine
ENV SSO_VERSION=8.2.25-1

# Install OpenLDAP server
RUN apk add --no-cache openldap openldap-back-bdb; \
	rm -rf /etc/openldap/*; \
	rm -rf /var/lib/openldap/*; \
	mkdir /var/run/openldap/; \
	chown ldap /var/run/openldap/

# Copy schemas and config templates from SSO media
COPY /sso-${SSO_VERSION}-unix.tar.gz /
RUN	tar -zxf /sso-${SSO_VERSION}-unix.tar.gz -C /tmp/; \
	rm /sso-${SSO_VERSION}-unix.tar.gz; \
	mv /tmp/ubilogin-sso/ubilogin/ldap/openldap/schema /etc/openldap/; \
	mv /tmp/ubilogin-sso/openldap/etc/openldap/schema/* /etc/openldap/schema/; \
	chown root.root /etc/openldap/schema -R; \
	chmod 444 /etc/openldap/schema/* -R; \
	rm -rf /tmp/ubilogin-sso

# Copy updated OpenLDAP configs
COPY /openldap/* /etc/openldap/

RUN	chown :ldap /etc/openldap/*; \
	chmod 640 /etc/openldap/*

EXPOSE 389
ENTRYPOINT ["/usr/sbin/slapd","-f","/etc/openldap/slapd.conf","-d","1"]
#,"-u","ldap","-g","ldap"]

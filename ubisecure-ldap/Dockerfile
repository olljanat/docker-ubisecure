FROM centos:7
ENV SSO_VERSION=8.2.19

# Install OpenLDAP server
RUN yum install -y openldap-servers openldap-clients

# Copy schemas and config templates from SSO media
COPY /sso-${SSO_VERSION}-unix.tar.gz /
RUN	rm -rf /etc/openldap/*; \
	tar -zxf /sso-${SSO_VERSION}-unix.tar.gz -C /tmp/; \
	rm /sso-${SSO_VERSION}-unix.tar.gz; \
	mv /tmp/ubilogin-sso/ubilogin/ldap/openldap/schema /etc/openldap/; \
	mv /tmp/ubilogin-sso/openldap/etc/openldap/schema/* /etc/openldap/schema/; \
	rm -rf /tmp/ubilogin-sso

# Copy updated OpenLDAP configs
COPY /openldap/* /etc/openldap/

# Create LDAP template files
COPY /ldap-init.ldif /root/
RUN /usr/sbin/slapd -T add -f /etc/openldap/slapd.conf -l /root/ldap-init.ldif; \
	mkdir /var/lib/ldap.template; \
	mv /var/lib/ldap/* /var/lib/ldap.template/; \
	rm /root/ldap-init.ldif

EXPOSE 389
ENTRYPOINT ["/usr/sbin/slapd","-f","/etc/openldap/slapd.conf","-d","1"]

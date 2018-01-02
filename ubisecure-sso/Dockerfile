FROM jboss/base-jdk:8
ENV SSO_VERSION=8.2.19
ENV CID_VERSION=5.2.12
ENV CID_SSO_ADAPTER_VERSION=5.0.29
ENV JRE_HOME=/usr/lib/jvm/java

USER root

# Pre-requirements
RUN yum install -y glibc.i686; \
	yum update -y libgcc; \
	yum install -y libgcc.i686 initscripts

COPY /sso-${SSO_VERSION}-unix.tar.gz /tmp
COPY /customerid-${CID_VERSION}-linux.tar.gz /tmp
RUN mkdir /usr/local/ubisecure/; \
	tar -zxf /tmp/sso-${SSO_VERSION}-unix.tar.gz -C /usr/local/ubisecure/; \
	rm /tmp/sso-${SSO_VERSION}-unix.tar.gz; \
	mkdir /tmp/cid-media; \
	tar -zxf /tmp/customerid-${CID_VERSION}-linux.tar.gz -C /tmp/cid-media; \
	rm /tmp/customerid-${CID_VERSION}-linux.tar.gz; \
	tar -zxf /tmp/cid-media/cid-sso-adapter-package-${CID_SSO_ADAPTER_VERSION}-linux.tar.gz -C /usr/local/ubisecure/; \
	rm -rf /tmp/cid-media/
	
WORKDIR /usr/local/ubisecure/ubilogin-sso/ubilogin

# Ubisecure Server
COPY /unix.config /usr/local/ubisecure/ubilogin-sso/ubilogin/
RUN ./setup.sh

# Ubisecure SSO Tomcat
RUN ./config/tomcat/install.sh; \
	ln -s  /sbin/pidof /sbin/pidofproc
	
	
# FixMe: https://developer.ubisecure.com/docs/display/IDS82/CustomerID+SSO+Adapter+Installation+On+Linux	

EXPOSE 8443
ENTRYPOINT ["/usr/local/ubisecure/ubilogin-sso/ubilogin/config/tomcat/jsvc.sh", "-nodetach", "org.apache.catalina.startup.Bootstrap"]
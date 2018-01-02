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
RUN mkdir /usr/local/ubisecure/; \
	tar -zxf /tmp/sso-${SSO_VERSION}-unix.tar.gz -C /usr/local/ubisecure/; \
	rm /tmp/sso-${SSO_VERSION}-unix.tar.gz
	
WORKDIR /usr/local/ubisecure/ubilogin-sso/ubilogin

# Ubisecure Server
COPY /unix.config /usr/local/ubisecure/ubilogin-sso/ubilogin/
RUN ./setup.sh

# Ubisecure SSO Tomcat
RUN ./config/tomcat/install.sh; \
	ln -s  /sbin/pidof /sbin/pidofproc


EXPOSE 8443
ENTRYPOINT ["/usr/local/ubisecure/ubilogin-sso/ubilogin/config/tomcat/jsvc.sh", "-nodetach", "org.apache.catalina.startup.Bootstrap"]
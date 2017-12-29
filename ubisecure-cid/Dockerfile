FROM jboss/wildfly:10.1.0.Final
ENV CID_VERSION=5.2.7
ENV CID_TEMPLATE_VERSION=1.1.18
ENV POSTGRESQL_DRIVER_VERSION=42.0.0
ENV JRE_HOME=/usr/lib/jvm/java

USER root
COPY /customerid-${CID_VERSION}-linux.tar.gz /tmp
RUN mkdir /tmp/cid-media; \
	cd /tmp/cid-media; \
	tar -zxf /tmp/customerid-${CID_VERSION}-linux.tar.gz; \
	rm /tmp/customerid-${CID_VERSION}-linux.tar.gz; \
	cp *.ear /opt/jboss/wildfly/standalone/deployments/; \
	mkdir /usr/local/ubisecure/; \
	cp postgresql-${POSTGRESQL_DRIVER_VERSION}.jar /usr/local/ubisecure/;\
	cd /usr/local/ubisecure/; \
	tar -zxf /tmp/cid-media/cid-deployment-template-${CID_TEMPLATE_VERSION}-linux.tar.gz; \
	rm -rf /tmp/cid-media/

COPY init-cid-db.sh /root
RUN yum install -y openldap-clients postgresql; \
	chmod u+x /root/init-cid-db.sh

COPY linux.config /usr/local/ubisecure/customerid/application/
RUN /usr/local/ubisecure/customerid/application/setup.sh
COPY configuration/* /opt/jboss/wildfly/domain/configuration/

USER jboss
EXPOSE 7443
CMD ["/opt/jboss/wildfly/bin/domain.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

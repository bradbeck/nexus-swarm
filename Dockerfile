FROM       bradbeck/nexus-ha
MAINTAINER Brad Beck <bradley.beck+docker@gmail.com>

ARG HDSD_VERSION=1.0-RC8
ARG HDSD_JAR=hazelcast-docker-swarm-discovery-spi-${HDSD_VERSION}.jar
ARG HDSD_MAVEN_PATH=org/bitsofinfo/hazelcast-docker-swarm-discovery-spi/${HDSD_VERSION}/${HDSD_JAR}
ARG HDSD_DOWNLOAD_URL=https://bintray.com/bitsofinfo/maven/${HDSD_MAVEN_PATH}
ARG NEXUS_VERSION=3.14.0-04

USER root

ADD ${HDSD_DOWNLOAD_URL} /opt/sonatype/nexus/system/${HDSD_MAVEN_PATH}
ADD hazelcast-network-default.xml /opt/sonatype/nexus/etc/fabric/hazelcast-network-default.xml
#<bundle>wrap:mvn:org.bitsofinfo/hazelcast-docker-swarm-discovery-spi/${HDSD_VERSION}</bundle>
RUN sed -i '/feature>/i\<bundle>wrap:mvn:org.bitsofinfo/hazelcast-docker-swarm-discovery-spi/'${HDSD_VERSION}'</bundle>' \
    /opt/sonatype/nexus/system/com/sonatype/nexus/plugins/nexus-hazelcast-plugin/${NEXUS_VERSION}/nexus-hazelcast-plugin-${NEXUS_VERSION}-features.xml && \
    sed -i '/<properties>/a\    <property name="hazelcast.discovery.enabled">true</property>' /opt/sonatype/nexus/etc/fabric/hazelcast.xml
USER nexus

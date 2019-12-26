FROM       bradbeck/nexus-ha
MAINTAINER Brad Beck <bradley.beck+docker@gmail.com>

ARG HS_VERSION=1.0.1
ARG HS_JAR=hazelcast-swarm-${HS_VERSION}.jar
ARG HS_MAVEN_PATH=org/sonatype/hazelcast/hazelcast-swarm/${HS_VERSION}/${HS_JAR}
ARG HS_DOWNLOAD_URL=https://search.maven.org/remotecontent?filepath=${HS_MAVEN_PATH}

USER root

ADD ${HS_DOWNLOAD_URL} /opt/sonatype/nexus/system/${HS_MAVEN_PATH}
ADD hazelcast-network-default.xml /opt/sonatype/nexus/etc/fabric/hazelcast-network-default.xml

RUN chmod 644 /opt/sonatype/nexus/system/${HS_MAVEN_PATH} && \
    sed -i '/mvn:com.sonatype.nexus.plugins\/nexus-hazelcast-plugin/a\        <bundle>mvn:org.sonatype.hazelcast/hazelcast-swarm/'${HS_VERSION}'</bundle>' \
      /opt/sonatype/nexus/system/com/sonatype/nexus/assemblies/nexus-flags-feature/*/nexus-flags-feature-*-features.xml && \
    sed -i '/<properties>/a\    <property name="hazelcast.discovery.enabled">true</property>' \
      /opt/sonatype/nexus/etc/fabric/hazelcast.xml

USER nexus

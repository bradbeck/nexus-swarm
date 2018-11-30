# bradbeck/nexus-swarm

A Dockerfile for Sonatype Nexus Repository Manager 3 ready for Docker Swarm.

GitHub Repository: https://github.com/bradbeck/nexus-swarm

To (re)build the image:

```
$ docker build --rm -t bradbeck/nexus-swarm .
```

```
docker service create --name nginx --replicas 1 --network overlay -p 8081:8081 bradbeck/nxrm-nginx
docker service create --name nxrm --replicas 1 --network overlay --endpoint-mode dnsrr --mount 'type=volume,src=java-prefs,dst=/opt/sonatype/sonatype-work/nexus3/javaprefs' --mount 'type=volume,src=shared-blobs,dst=/opt/sonatype/sonatype-work/nexus3/blobs' bradbeck/nexus-swarm
```

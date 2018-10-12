# bradbeck/nexus-swarm

A Dockerfile for Sonatype Nexus Repository Manager 3 ready for Docker Swarm.

GitHub Repository: https://github.com/bradbeck/nexus-swarm

To (re)build the image:

```
$ docker build --rm -t bradbeck/nexus-swarm .
```

```
docker run --rm -p 8081:8081 -v java-prefs:/opt/sonatype/sonatype-work/nexus3/javaprefs --network custom -it bradbeck/nexus-swarm
```

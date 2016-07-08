Docker Zookeeper
================

Tags:

- 3.4.8, 3.4, 3, latest ([Dockerfile](https://github.com/znly/docker-zookeeper/blob/master/Dockerfile))

What is ZooKeeper?
==================

ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications. Each time they are implemented there is a lot of work that goes into fixing the bugs and race conditions that are inevitable. Because of the difficulty of implementing these kinds of services, applications initially usually skimp on them ,which make them brittle in the presence of change and difficult to manage. Even when done correctly, different implementations of these services lead to management complexity when the applications are deployed.

Learn more about ZooKeeper on the [ZooKeeper Wiki](https://cwiki.apache.org/confluence/display/ZOOKEEPER/Index).

How to use?
===========

Run as a single node as simple as :

```
docker run znly/zookeeper
```

Let's run a cluster :

Create a network:

```
docker network create zoo
```

Run a 3 nodes cluster :

```
docker run -d \ 
    --net=zoo \
    --name=zookeeper1 \
    -e "ZOO_ID=1" \
    -e="ZOO_SERVERS=zookeeper1,zookeeper2,zookeeper3" \
    znly/zookeeper
    
docker run -d \ 
    --net=zoo \
    --name=zookeeper2 \
    -e "ZOO_ID=2" \
    -e="ZOO_SERVERS=zookeeper1,zookeeper2,zookeeper3" \
    znly/zookeeper

docker run -d \ 
    --net=zoo \
    --name=zookeeper3 \
    -e "ZOO_ID=3" \
    -e="ZOO_SERVERS=zookeeper1,zookeeper2,zookeeper3" \
    znly/zookeeper

```

Zookeeper is relying heavily on 3 options :

- The hostname of the node (container name)
- The node id (ZOO_ID), acting as a uniq node identifier
- The server list (ZOO_SERVERS) for discovery purposes

Run a cluster with docker compose:
=================================

Clone the source: 

```
git clone git@github.com:znly/docker-zookeeper.git
```

And run docker-compose (v2 file):

```
docker-compose up
```


Configuration
=============

Available environment options:

- `JVM_HEAP_MEMORY` "1g"
- `ZOOKEEPER_VERSION` 3.4.8
- `ZOO_SERVERS` "zookeeper1"
- `ZOO_ID` "1"
- `ZOO_DATA_DIR` "/data/zookeeper"


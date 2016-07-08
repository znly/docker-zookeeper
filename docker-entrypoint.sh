#!/bin/sh

# Setup myid for each node
if [ -z "$ZOO_ID" ]; then
    exit 1
fi

echo "$ZOO_ID" > /data/zookeeper/myid

# From mesos-cloud zookeeper
#
cat > /opt/zookeeper/conf/zoo.cfg <<EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=${ZOO_DATA_DIR}
clientPort=2181
maxClientCnxns=100
autopurge.snapRetainCount=2
autopurge.purgeInterval=1
EOF

# server.1=...
if [ -n "$ZOO_SERVERS" ]; then
    printf '%s' "$ZOO_SERVERS" | awk 'BEGIN { RS = "," }; { printf "server.%i=%s:2888:3888\n", NR, $0 }' >> /opt/zookeeper/conf/zoo.cfg
fi
#
##

# Start the beast in foreground
/opt/zookeeper/bin/zkServer.sh start-foreground

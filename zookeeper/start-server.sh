#!/bin/bash

if [ -z ${ZOO_ID} ] ; then
  echo 'No ID specified, please specify one between 1 and 255'
  exit -1
fi

if [ ! -f /zoo/conf/zoo.cfg ] ; then
  echo 'Waiting for config file to appear...'
  while [ ! -f /zoo/conf/zoo.cfg ] ; do
    sleep 1
  done
  echo 'Config file found, starting server.'
fi

mkdir -p /var/lib/zookeeper

echo "${ZOO_ID}" > /var/lib/zookeeper/myid

# /zookeeper/bin/zkServer.sh start-foreground
/zookeeper/bin/zkServer.sh 
mkdir /var/run/sshd
/usr/sbin/sshd -D

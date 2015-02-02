#!/bin/bash

set -e

rm -f conf/zoo.cfg
# Need a volume to read the config from
conf_container=zoo1

# Start the zookeeper containers
for i in {1..3} ; do
  if [ "${i}" == "1" ] ; then
    sudo docker run -p 220$i:22 -d -v $(pwd)/conf:/zoo/conf --name "zoo${i}" -h "zoo${i}" -e ZOO_ID=${i} zookeeper
  else
    sudo docker run -p 220$i:22 -d -v $(pwd)/conf:/zoo/conf --name "zoo${i}" -h "zoo${i}" -e ZOO_ID=${i} zookeeper
  fi
done

config=$(cat zoo.cfg.initial)

# Look up the zookeeper instance IPs and create the config file
for i in {1..3} ; do
  container_name=zoo${i}
  container_ip=$(sudo docker inspect --format '{{.NetworkSettings.IPAddress}}' ${container_name})
  line="server.${i}=${container_ip}:2888:3888"
  config="${config}"$'\n'"${line}"
done

# Write the config to the config container
# echo "${config}" | docker run -i --rm --volumes-from ${conf_container} busybox sh -c 'cat > /zoo/conf/zoo.cfg'
echo "${config}" > conf/zoo.cfg

#!/bin/bash

# Change to track a different container in Elastic
TRACKED_CONTAINER=dsom-identifier_api_1

# Leave everything from here down alone
CONFIG_DIR=/usr/share/filebeat
TEMPLATE=$CONFIG_DIR/template.yml
CONFIG=$CONFIG_DIR/filebeat.yml
CONTAINERS=/var/lib/docker/containers

if [ "$1" = "start" ]; then
  DOCKER_SOCKET=/var/run/docker.sock
  DOCKER_GROUP=docker
  REGULAR_USER=root
  
  if [ -S ${DOCKER_SOCKET} ]; then
      DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
      groupadd -for -g ${DOCKER_GID} ${DOCKER_GROUP}
      usermod -aG ${DOCKER_GROUP} ${REGULAR_USER}
  fi

  CONTAINER_ID=`docker ps --filter name=$TRACKED_CONTAINER --no-trunc -q`
  sed "s/{{CONTAINER}}/$CONTAINER_ID/" $TEMPLATE > $CONFIG
  chmod 600 $CONFIG

  cat $CONFIG

  filebeat -e -v -c $CONFIG
else
  exec "$@"
fi

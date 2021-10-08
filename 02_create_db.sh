#!/bin/bash

source nextcloud.properties

IMAGE="docker.io/library/mariadb:latest"
POD="--pod ${POD_NAME}"
VOLUME="database"
VOLUMES="-v $(pwd)/${VOLUME}:/var/lib/mysql:z"
ENV="-e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DATABASE=nextcloud -e MYSQL_USER=nextcloud"
COMMAND="--transaction-isolation=READ-COMMITTED --binlog-format=ROW --innodb-file-per-table=1 --skip-innodb-read-only-compressed"
OPTIONS="-d --rm"

create_dir ${VOLUME}
#${ENGINE} unshare chown 999:999 ${VOLUME}

${ENGINE} run \
  ${POD} \
  ${OPTIONS} \
  --name ${CONTAINER_DB_NAME} \
  ${ENV} \
  ${VOLUMES} \
  ${IMAGE} \
  ${COMMAND}


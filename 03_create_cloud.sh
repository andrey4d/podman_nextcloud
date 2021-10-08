#!/bin/bash

source nextcloud.properties

IMAGE="docker.io/library/nextcloud:fpm"
POD="--pod ${POD_NAME}"
VOLUME="nextcloud"
VOLUMES="-v $(pwd)/${VOLUME}:/var/www/html:z"
ENV="-e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DATABASE=nextcloud -e MYSQL_USER=nextcloud -e MYSQL_HOST=127.0.0.1:3306"
OPTIONS="-d --rm"

create_dir ${VOLUME}

${ENGINE} run \
  ${POD} \
  ${OPTIONS} \
  --name ${CONTAINER_APP_NAME} \
  ${ENV} \
  ${VOLUMES} \
  ${IMAGE} \
  ${COMMAND}


#!/bin/bash

source nextcloud.properties

VOLUME="nextcloud"

create_dir ${VOLUME_APP}
run_container \
  "--pod ${POD_NAME}" \
  "-d --rm" \
  "${CONTAINER_APP_NAME}" \
  "-e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DATABASE=nextcloud -e MYSQL_USER=nextcloud -e MYSQL_HOST=127.0.0.1:3306" \
  "-v $(pwd)/${VOLUME_APP}:/var/www/html:z" \
  "${IMAGE_APP}" \
  ""


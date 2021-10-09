#!/bin/bash

source nextcloud.properties

create_dir ${VOLUME_DB}
run_container \
  "--pod ${POD_NAME}" \
  "-d --rm" \
  "${CONTAINER_DB_NAME}" \
  "-e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DATABASE=nextcloud -e MYSQL_USER=nextcloud" \
  "-v $(pwd)/${VOLUME_DB}:/var/lib/mysql:z" \
  "${IMAGE_DB}" \
  "--transaction-isolation=READ-COMMITTED --binlog-format=ROW --innodb-file-per-table=1 --skip-innodb-read-only-compressed"

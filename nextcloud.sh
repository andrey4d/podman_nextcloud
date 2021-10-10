#!/bin/bash

source nextcloud.properties

if [[ ! $(get_object_id "network" "${NETWORK_NAME}") ]]; then
    echo "Create network ${NETWORK_NAME}."
    ${ENGINE} network create "${NETWORK_NAME}"
  else
    echo "Network ${NETWORK_NAME} already exists"
fi

if [[ ! $(get_object_id "pod" "${POD_NAME}") ]]; then
    echo "Create POD ${POD_NAME} connect to network ${NETWORK_NAME} listen ports ${PORTS}."
    ${ENGINE} pod create --name "${POD_NAME}" --network ${NETWORK_NAME} ${PORTS}
  else
    echo "POD ${POD_NAME} already exists"
fi

if [[ ! $(get_object_id "container" "${CONTAINER_DB_NAME}") ]]; then
    echo "Create container ${CONTAINER_DB_NAME} in pod ${POD_NAME}."
    create_dir ${VOLUME_DB}
    run_container \
      "--pod ${POD_NAME}" \
      "-d --rm" \
      "${CONTAINER_DB_NAME}" \
      "-e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DATABASE=nextcloud -e MYSQL_USER=nextcloud" \
      "-v ${VOLUME_DB}:/var/lib/mysql:z" \
      "${IMAGE_DB}" \
      "--transaction-isolation=READ-COMMITTED --binlog-format=ROW --innodb-file-per-table=1 --skip-innodb-read-only-compressed"
  else
    echo "Container ${CONTAINER_DB_NAME} already exists"
fi

if [[ ! $(get_object_id "container" "${CONTAINER_APP_NAME}") ]]; then
    echo "Create container ${CONTAINER_APP_NAME} in pod ${POD_NAME}."
    create_dir ${VOLUME_APP}
    run_container \
      "--pod ${POD_NAME}" \
      "-d --rm" \
      "${CONTAINER_APP_NAME}" \
      "-e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DATABASE=nextcloud -e MYSQL_USER=nextcloud -e MYSQL_HOST=127.0.0.1:3306" \
      "-v ${VOLUME_APP}:/var/www/html:z" \
      "${IMAGE_APP}" \
      ""
  else
    echo "Container ${CONTAINER_APP_NAME} already exists"
fi

if [[ ! $(get_object_id "container" "${CONTAINER_WEB_NAME}") ]]; then
    echo "Create container ${CONTAINER_WEB_NAME} in pod ${POD_NAME}."
    CERT_DIR="${VOLUME_NGINX}"

    if [[ ! -d "${CERT_DIR}" ]]; then
      mkdir -p "${CERT_DIR}"
      openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "${CERT_DIR}/${DOMAIN}.key" -out "${CERT_DIR}/${DOMAIN}.crt"
      nginx_conf "${CERT_DIR}"
    fi

    run_container \
      "--pod ${POD_NAME}" \
      "-d --rm" \
      "${CONTAINER_WEB_NAME}" \
      "" \
      "
      -v ${VOLUME_APP}:/var/www/html:z \
      -v ${VOLUME_NGINX}/nginx_https.conf:/etc/nginx/nginx.conf:z \
      -v ${VOLUME_NGINX}/${DOMAIN}.crt:/etc/ssl/nginx/dvampere.crt:z \
      -v ${VOLUME_NGINX}/${DOMAIN}.key:/etc/ssl/nginx/dvampere.key:z \
      " \
      "${IMAGE_WEB}" \
      ""
  else
    echo "Container ${CONTAINER_WEB_NAME} already exists"
fi

${ENGINE} ps
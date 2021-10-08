#!/bin/bash

source nextcloud.properties

IMAGE="docker.io/library/nginx:latest"
POD="--pod ${POD_NAME}"

DOMAIN="dvampere"

VOLUME_NEXTCLOUD="nextcloud"
VOLUMES="-v $(pwd)/${VOLUME_NEXTCLOUD}:/var/www/html:z \
  -v $(pwd)/nginx/nginx_https.conf:/etc/nginx/nginx.conf:z \
  -v $(pwd)/nginx/${DOMAIN}.crt:/etc/ssl/nginx/dvampere.crt:z \
  -v $(pwd)/nginx/${DOMAIN}.key:/etc/ssl/nginx/dvampere.key:z"
ENV=""
OPTIONS="-d --rm"

CERT_DIR="$(pwd)/nginx"

if [[ ! -d "${CERT_DIR}" ]]; then
  mkdir -p "${CERT_DIR}"
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "${CERT_DIR}/${DOMAIN}.key" -out "${CERT_DIR}/${DOMAIN}.crt"
  nginx_conf "${CERT_DIR}"
fi

${ENGINE} run \
  ${POD} \
  ${OPTIONS} \
  --name ${CONTAINER_WEB_NAME} \
  ${ENV} \
  ${PORTS} \
  ${VOLUMES} \
  ${IMAGE} \
  ${COMMAND}


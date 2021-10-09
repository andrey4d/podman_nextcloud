#!/bin/bash

source nextcloud.properties

CERT_DIR="$(pwd)/${VOLUME_NGINX}"

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
  "-v $(pwd)/${VOLUME_APP}:/var/www/html:z \
  -v $(pwd)/nginx/nginx_https.conf:/etc/nginx/nginx.conf:z \
  -v $(pwd)/nginx/${DOMAIN}.crt:/etc/ssl/nginx/dvampere.crt:z \
  -v $(pwd)/nginx/${DOMAIN}.key:/etc/ssl/nginx/dvampere.key:z" \
  "${IMAGE_WEB}" \
  ""


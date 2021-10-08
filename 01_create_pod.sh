#!/bin/bash

source nextcloud.properties

PORTS="-p 2080:80 -p 2443:443"

${ENGINE} network create "${NETWORK_NAME}"
${ENGINE} pod create --name "${POD_NAME}" --network ${NETWORK_NAME} ${PORTS}

#!/bin/bash

source nextcloud.properties

${ENGINE} network create "${NETWORK_NAME}"
${ENGINE} pod create --name "${POD_NAME}" --network ${NETWORK_NAME} ${PORTS}

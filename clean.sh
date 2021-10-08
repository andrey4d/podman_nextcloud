#!/bin/bash
source nextcloud.properties

${ENGINE} pod stop "${POD_NAME}"
#${ENGINE} stop "${CONATINER_DB_NAME}"
${ENGINE} pod rm "${POD_NAME}"
${ENGINE} network rm "${NETWORK_NAME}"

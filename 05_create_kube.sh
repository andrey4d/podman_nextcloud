#!/bin/bash

source nextcloud.properties

${ENGINE} generate kube "${POD_NAME}" > nextcloud_kube.yml
# podman_nextcloud

###RUN
```
./nextcloud run
```
###CLEAN
```
./nextcloud clean
```
###Show containers
```
./nextcloud ps
```
###Create k8s YAML file
```
./nextcloud kube
```
##PROPERTIES
###POD properties
```
NETWORK_NAME="nextcloud_net"
POD_NAME="nextcloud_pod"
PORTS="-p 2080:80 -p 2443:443"
```
###Images
```
IMAGE_DB="docker.io/library/mariadb:latest"
IMAGE_APP="docker.io/library/nextcloud:fpm-alpine"
IMAGE_WEB="docker.io/library/nginx:latest"
```
###Containers names
```
CONTAINER_DB_NAME="nextcloud_db"
CONTAINER_APP_NAME="nextcloud_app"
CONTAINER_WEB_NAME="nextcloud_nginx"
```

###Containers volume
```
VOLUME_ROOT="$(pwd)/volumes"
VOLUME_DB="${VOLUME_ROOT}/database"
VOLUME_APP="${VOLUME_ROOT}/nextcloud"
VOLUME_NGINX="${VOLUME_ROOT}/nginx"
```

###Database 
```
MYSQL_ROOT_PASSWORD='Pa$$w0rd'
MYSQL_PASSWORD='Pa$$w0rd'
```
###File for "podman play kube"
```
KUBE_FILE="nextcloud_kube"
```
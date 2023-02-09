# podman_nextcloud

### RUN
```
./nextcloud run
```
###  Delete POD
```
./nextcloud rm
```
### Show containers
```
./nextcloud ps
```
### Create systemd unit files
```
./nextcloud systemd
```
### Create k8s YAML file
```
./nextcloud kube
```
## PROPERTIES
### POD properties
Edit properties files nextcloud.properties and openssl.properties
```shell
vi nextcloud.properties
```
```
NETWORK_NAME="nextcloud_net"
POD_NAME="nextcloud_pod"
PORTS="-p 2080:80 -p 2443:443 -p 9980:9980"
```
### Images
```
IMAGE_DB="docker.io/library/mariadb:latest"
IMAGE_APP="docker.io/library/nextcloud:fpm-alpine"
IMAGE_WEB="docker.io/library/nginx:latest"
IMAGE_COLLABORA="docker.io/collabora/code:latest"
```
### Containers names
```
CONTAINER_DB_NAME="nextcloud_db"
CONTAINER_APP_NAME="nextcloud_app"
CONTAINER_WEB_NAME="nextcloud_nginx"
CONTAINER_COLLABORA_NAME="nextcloud_collabora"
```
### Containers volume
```
VOLUME_ROOT="$(pwd)/volumes"
VOLUME_DB="${VOLUME_ROOT}/database"
VOLUME_APP="${VOLUME_ROOT}/nextcloud"
VOLUME_NGINX="${VOLUME_ROOT}/nginx"
VOLUME_COLLABORA="${VOLUME_ROOT}/collabora"
```
### Passwords 
```
MYSQL_ROOT_PASSWORD='Pa$$w0rd'
MYSQL_PASSWORD='Pa$$w0rd'
COLLABORA_password='Pa$$w0rd'
```
### Openssl properies
```
OPENSSL_PROPERTIES="openssl.properties"
```
### File for "podman play kube"
```
KUBE_FILE="nextcloud_kube"
```


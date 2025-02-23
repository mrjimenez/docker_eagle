#!/bin/bash

#DISPLAY=$(ifconfig br0 | awk '/inet / {print $6}'):0
#echo "$DISPLAY"

# Set MAC Address
LICENSE_MAC=${LICENSE_MAC:-"01:ab:23:cd:45:ef"}

# Set XAUTHORITY, if not set
XAUTHORITY="${XAUTHORITY:-${HOME}/.Xauthority}"
#echo "$XAUTHORITY"

# The Eagle version.
EAGLE_VERSION=6.6.0

# Useful flags for debugging
#        -u 0 \
#        --rm \
docker run \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/localtime:/etc/localtime:ro \
        -v "$XAUTHORITY":/home/ubuntu/.Xauthority:ro \
        -v "$HOME":/home/ubuntu/shared \
        -v "$HOME"/eagle:/home/ubuntu/eagle \
        -e QT_X11_NO_MITSHM=1 \
        -e DISPLAY="$DISPLAY" \
        -it \
        --name docker_eagle \
        --net=host --ipc=host \
        --mac-address "$LICENSE_MAC" \
        eagle:"${EAGLE_VERSION}"

# Useful for debugging
#docker exec -it docker_eagle /bin/bash
#docker start docker_eagle
#docker stop docker_eagle
#docker rm docker_eagle
#docker rmi eagle:6.6.0
#docker ps -a
#docker images
#docker network ls
#docker network inspect host
#docker network inspect bridge
#docker network inspect none
#docker network inspect container:docker_eagle

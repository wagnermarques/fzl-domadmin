#!/bin/bash

docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 \
-v portainer_data:/data \
       --name portainer --restart=always portainer/portainer-ce:lts

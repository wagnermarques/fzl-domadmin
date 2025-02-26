#!/bin/bash

#https://docs.portainer.io/start/install-ce/server/docker

# Check if portainer_data volume exists
if ! docker volume ls -q | grep -q "^portainer_data$"; then
    echo "Creating portainer_data volume..."
    docker volume create portainer_data
else
    echo "Volume portainer_data already exists"
fi

# Check if portainer container exists
if ! docker ps -a --format "{{.Names}}" | grep -q "^portainer$"; then
    echo "Creating and starting portainer container..."
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
elif ! docker ps --format "{{.Names}}" | grep -q "^portainer$"; then
    echo "Portainer container exists but is not running. Starting it..."
    docker start portainer
else
    echo "Portainer container is already running"
fi

# Wait a moment for the container to be ready
echo "Waiting for Portainer to initialize..."
sleep 3

# Open Firefox only if the container is running
if docker ps --format "{{.Names}}" | grep -q "^portainer$"; then
    echo "Opening Portainer interface in Firefox..."
    firefox http://localhost:9443
else
    echo "Error: Portainer container is not running"
fi

firefox https://localhost:9443
admin admin123admin123

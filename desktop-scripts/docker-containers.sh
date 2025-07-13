#!/bin/bash

CONTAINERS_ARTIFACTS_DIR=~/containers_artifacts

function fzl-docker-run-mysql-8(){
    ROOT_PASSWORD=1234;
    CONTAINER_NAME=edutec2rodr
    HOST_PORT=3336
    docker volume create $CONTAINER_NAME
    sudo docker run -d \
        --name $CONTAINER_NAME \
        -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
        -e MYSQL_DATABASE=moodle \
        -e MYSQL_USER=moodle \
        -e MYSQL_PASSWORD=1234 \
        -v $CONTAINER_NAME:/var/lib/mysql \
        -p $HOST_PORT:3306 \
        mysql:8
}
export fzl-docker-run-mysql-8



function fzl-docker-phpmyadmin-star(){
    CONTAINER_LINK=$1
    PHPMYADMIN_HOST_PORT=$2
    
    docker run \
	   --name phpmyadmin \
	   -d --link $CONTAINER_LINK:db \
	   -p $PHPMYADMIN_HOST_PORT:80 phpmyadmin
}
export -f fzl-docker-phpmyadmin-star

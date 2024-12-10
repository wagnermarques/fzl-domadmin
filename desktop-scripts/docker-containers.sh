#!/bin/bash

function fzl-docker-run-mysql-8(){
    ROOT_PASSWORD=1234;
    CONTAINER_NAME=mysql8
    VOLUMETOUSE=containers_dev-odin2-mysql8
    HOST_PORT=3336
    sudo docker run -d \
        --name $CONTAINER_NAME \
        -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
        -v $VOLUMETOUSE:/var/lib/mysql \
        -p $HOST_PORT:3306 \
        mysql:8
}
export fzl-docker-run-mysql-8

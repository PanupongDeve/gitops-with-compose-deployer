#!/bin/sh
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo "------------> Create Network..."
./netowork.create.sh

echo "------------> Create Infrastructure..."

if [ "$nginx" = "1" ];then
docker-compose -f ./infrastructure/docker-compose.web-server.yaml up -d
fi

if [ "$mysql" = "1" ];then
docker-compose -f ./infrastructure/docker-compose.mysql.yaml up -d
fi

echo "------------> Create Applications..."
# docker-compose -f ./applications/*.yaml up -d

if [ "$pod_health" = "1" ];then
docker-compose -f ./applications/docker-compose.applications.yaml up -d
fi

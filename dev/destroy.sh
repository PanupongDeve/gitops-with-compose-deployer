#!/bin/sh
if [ -f .env.config ]
then
  export $(cat .env.config | sed 's/#.*//g' | xargs)
fi


echo "------------> Delete Applications..."
# docker-compose -f ./applications/*.yaml down

if [ "$pod_health" = "1" ];then
docker-compose -f ./applications/docker-compose.applications.yaml down
fi


echo "------------> Delete Infrastructure..."
if [ "$nginx" = "1" ];then
docker-compose -f ./infrastructure/docker-compose.web-server.yaml down
fi

if [ "$mysql" = "1" ];then
docker-compose -f ./infrastructure/docker-compose.mysql.yaml down
fi

echo "------------> Delete Network..."
./netowork.delete.sh



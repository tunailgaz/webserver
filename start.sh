#!/bin/bash

docker network create -d overlay --attachable nginx
# Download the latest version of nginx.tmpl
#curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > nginx.tmpl


# 5. Update local images
docker-compose -f docker-stack-nginx.yml pull
docker stack deploy -c docker-stack-nginx.yml nginx
exit 0

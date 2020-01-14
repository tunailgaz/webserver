# Docker Swarm Nginx Webserver
docker stack with those images
-   nginx
-   helder/docker-gen:latest
-   jrcs/letsencrypt-nginx-proxy-companion

helder/docker-gen will listen docker.sock and trigger etsencrypt-nginx-proxy-companion image which will update nginx container with necessary configurations
all you need to do run stack file on swarm mode

      - VIRTUAL_HOST=chat.imgfortweet.com
      - VIRTUAL_PORT=3000
      - LETSENCRYPT_HOST=chat.imgfortweet.com
      - LETSENCRYPT_EMAIL=tunailgaz@gmail.com 

when you start your web-app container with those env values       
nginx container /etc/nginx/conf.d/default.conf will be created and updated

to mannually restart nginx container

       - docker container exec (nginx container id) nginx -s reload  
       
to test nginx configuration 
       
       - docker container exec (nginx container id) nginx -t  

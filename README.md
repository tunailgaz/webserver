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

if you want to edit use custom nginx configurations you need to put a conf file into `nginx-vhost.d` volume which is external. 



### serving static files
if you want to serve static files from nginx
for example you have 'www.example.com' domain, and you run your web-app container with `- VIRTUAL_HOST=www.example.com`
 
create a file named `www.example.com.conf` (this should match with `VIRTUAL_HOST`) and put it into `nginx-vhost.d` volume

check ./examples/vhost.d folder for example custom settings 

in your `www.example.com.conf` file define how can nginx container access those static files `root /usr/share/nginx/html/www.example.com/static;`
finally put your static folder into `nginx-html` volume


yes a bit dirty and hacky but makes the job done. 
how about dynamic files?, you can create your own script that copies dynamic files into nginx shared folder same concept.
 


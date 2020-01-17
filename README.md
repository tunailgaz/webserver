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

[read full docs](https://github.com/jwilder/nginx-proxy) 
```
    SSL

    To serve traffic in both SSL and non-SSL modes without redirecting to SSL, you can include the environment variable
    HTTPS_METHOD=noredirect (the default is HTTPS_METHOD=redirect). You can also disable the non-SSL site entirely with
    HTTPS_METHOD=nohttp, or disable the HTTPS site with HTTPS_METHOD=nohttps. 
    HTTPS_METHOD must be specified on each container for which you want to override the default behavior. 
    If HTTPS_METHOD=noredirect is used, Strict Transport Security (HSTS) is disabled to prevent HTTPS users from being
    redirected by the client.

    If you cannot get to the HTTP site after changing this setting, your browser has probably cached the HSTS policy and
    is automatically redirecting you back to HTTPS. You will need to clear your browser's HSTS cache or use an incognito
    window / different browser.
    
    By default, HTTP Strict Transport Security (HSTS) is enabled with max-age=31536000 for HTTPS sites. You can disable HSTS
    with the environment variable HSTS=off or use a custom HSTS configuration like HSTS=max-age=31536000; includeSubDomains;
    preload. WARNING: HSTS will force your users to visit the HTTPS version of your site for the max-age time - even if they
    type in http:// manually. The only way to get to an HTTP site after receiving an HSTS response is to clear your
    browser's HSTS cache.
    
```

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
 


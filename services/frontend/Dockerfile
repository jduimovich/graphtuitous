FROM nginxinc/nginx-unprivileged 
 
EXPOSE 8080

COPY default.conf /etc/nginx/conf.d/default.conf  
 
WORKDIR /usr/share/nginx/html/
COPY html /usr/share/nginx/html/
COPY run.sh .
 
CMD ["/bin/sh", "run.sh"]
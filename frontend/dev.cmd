cd %~dp0 

SET HTML=-v %CD%\html:/usr/share/nginx/html:ro
SET CONFIG=-v %CD%\local:/etc/nginx/conf.d:ro

docker stop nginx
docker rm nginx
docker run --rm --name nginx -p 8888:8080 %HTML% %CONFIG% -d docker.io/nginx

start http://localhost:8888


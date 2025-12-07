
script_dir=$(dirname "$0") 
cd $script_dir 
CD=$(pwd) 
HTML="-v $CD/html:/usr/share/nginx/html:ro"
CONFIG="-v $CD/local:/etc/nginx/conf.d:ro"
docker stop nginx >/dev/null 2>&1
docker rm nginx >/dev/null 2>&1
docker run  --rm --name nginx  -d -p 8089:8080 $HTML $CONFIG -d docker.io/nginx

 
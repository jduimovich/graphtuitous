

script_dir=$(dirname "$0") 
cd $script_dir 
CD=$(pwd)  
  
docker build -f Dockerfile.local -t haproxy-local .

docker stop haproxy >/dev/null 2>&1
docker rm haproxy >/dev/null 2>&1

docker run -p 8888:8080  -d --rm --name haproxy haproxy-local
 
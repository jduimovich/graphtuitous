

script_dir=$(dirname "$0") 
cd $script_dir 
CD=$(pwd)  
  
docker build -f Dockerfile.local -t haproxy-local .

docker stop haproxy
docker rm haproxy

docker run -p 8888:8080 --rm --name haproxy haproxy-local
 
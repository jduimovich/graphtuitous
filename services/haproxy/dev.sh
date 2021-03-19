

script_dir=$(dirname "$0") 
cd $script_dir 
CD=$(pwd)  

DOCKER_USER=$(sh $CD/../../hack/dockerusername.sh)

docker build -f Dockerfile.local -t $DOCKER_USER/frontend-haproxy-local .

docker stop haproxy
docker rm haproxy

docker run  -it -p 8888:8080 --rm --name haproxy   $DOCKER_USER/frontend-haproxy-local
 
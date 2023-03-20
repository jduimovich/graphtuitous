

script_dir=$(dirname "$0")
cd $script_dir/..  

DOCKER_USER=$(sh $script_dir/../hack/dockerusername.sh)

CURRENT_DIR=$(pwd) 

cd fib-go
docker build -t $DOCKER_USER/fib-go .

cd ../fib-node
docker build -t $DOCKER_USER/fib-node .

cd ../fib-quarkus
call build-image.bat

cd ../frontend
docker build -t $DOCKER_USER/frontend .

cd ../haproxy
docker build -t $DOCKER_USER/haproxy .

docker push $DOCKER_USER/fib-go
docker push $DOCKER_USER/fib-node
docker push $DOCKER_USER/fib-quarkus
docker push $DOCKER_USER/frontend
docker push $DOCKER_USER/haproxy
  
cd $CURRENT_DIR
script_dir=$(dirname "$0") 
cd $script_dir  
NAME=$(basename "$PWD" | tr '[:upper:]' '[:lower:]')
DEV_NAME="${NAME}-dev"
PORT=8082
bash _build

docker stop $DEV_NAME >/dev/null 2>&1
docker rm $DEV_NAME >/dev/null 2>&1 

docker run  --name $DEV_NAME  -d -v $(pwd):/app -p $PORT:8080 $DEV_NAME


script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
NAME=$(basename "$PWD" | tr '[:upper:]' '[:lower:]')
DEV_NAME="${NAME}-dev"

bash _build
docker stop $DEV_NAME >/dev/null 2>&1
docker rm $DEV_NAME >/dev/null 2>&1 
docker run  --name $DEV_NAME  -d -v $(pwd)/app.js:/usr/src/app/app.js -p 8081:8080 $DEV_NAME    


 

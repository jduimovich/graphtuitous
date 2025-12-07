script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
bash _build 

NAME=$(basename "$PWD" | tr '[:upper:]' '[:lower:]')
DEV_NAME="${NAME}-dev"

# run from northdepot data
HOME=$(pwd)
DATA=$HOME/html

docker stop $NAME >/dev/null 2>&1
docker rm $NAME >/dev/null 2>&1 

docker run  --name $NAME  -d -v $DATA:/app/data -p 8083:8000 $DEV_NAME


script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
bash _build 

# run from northdepot data
HOME=$(pwd)
DATA=$HOME/html

docker stop $NAME >/dev/null 2>&1
docker rm $NAME >/dev/null 2>&1 

docker run  -v $DATA:/app/data -p 8083:8000 fib-rust-dev 


script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
bash _build
docker run  -v $(pwd):/app -p 8082:8080 fib-go-dev 


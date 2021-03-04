script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
export PORT=8081
go run fib.go 
nodemon app.js

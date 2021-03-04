script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
export PORT=8082
go run fib.go



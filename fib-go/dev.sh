script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
go get -u github.com/cosmtrek/air
export PORT=8082
air



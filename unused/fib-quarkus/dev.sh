script_dir=$(dirname "$0") 
cd $script_dir 
echo $(pwd)
./mvnw  quarkus:dev


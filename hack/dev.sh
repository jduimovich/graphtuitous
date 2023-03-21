
 script_dir=$(dirname "$0")
cd $script_dir/..  

chmod +x  fib-node/dev.sh
chmod +x  fib-quarkus/dev.sh
chmod +x  fib-go/dev.sh
chmod +x  frontend/dev.sh 
chmod +x  haproxy/dev.sh 

$script_dir/openshell.sh  fib-node/dev.sh
$script_dir/openshell.sh  fib-quarkus/dev.sh
$script_dir/openshell.sh   fib-go/dev.sh
$script_dir/openshell.sh    frontend/dev.sh 
$script_dir/openshell.sh haproxy/dev.sh 
 
sleep 2
$script_dir/openshell.sh  http://localhost:8888
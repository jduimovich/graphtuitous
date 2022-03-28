
 script_dir=$(dirname "$0")
cd $script_dir/..  

chmod +x  services/fib-node/dev.sh
chmod +x  services/fib-quarkus/dev.sh
chmod +x  services/fib-go/dev.sh
chmod +x  services/frontend/dev.sh 
chmod +x  services/haproxy/dev.sh 

$script_dir/openshell.sh  services/fib-node/dev.sh
$script_dir/openshell.sh  services/fib-quarkus/dev.sh
$script_dir/openshell.sh   services/fib-go/dev.sh
$script_dir/openshell.sh    services/frontend/dev.sh 
$script_dir/openshell.sh services/haproxy/dev.sh 
 
sleep 2
$script_dir/openshell.sh  http://localhost:8888
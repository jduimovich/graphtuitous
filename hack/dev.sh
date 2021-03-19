
 script_dir=$(dirname "$0")
cd $script_dir/..  

chmod +x  services/fib-node/dev.sh
chmod +x  services/fib-quarkus/dev.sh
chmod +x  services/fib-go/dev.sh
chmod +x  services/frontend/dev.sh 
chmod +x  services/haproxy/dev.sh 

open -a Terminal  services/fib-node/dev.sh
open -a Terminal   services/fib-quarkus/dev.sh
open -a Terminal   services/fib-go/dev.sh
open -a Terminal   services/frontend/dev.sh 
open -a Terminal  services/haproxy/dev.sh 
 
sleep 2
open http://localhost:8888
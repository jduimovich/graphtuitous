
 script_dir=$(dirname "$0")
cd $script_dir/..  

chmod +x  fib-node/dev.sh 
chmod +x  fib-go/dev.sh
chmod +x  frontend/dev.sh 
chmod +x  haproxy/dev.sh 

fib-node/dev.sh &
fib-go/dev.sh &
fib-rust/dev.sh &
frontend/dev.sh &
haproxy/dev.sh &
 
sleep 2
echo http://localhost:8888
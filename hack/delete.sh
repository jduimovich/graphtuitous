
script_dir=$(dirname "$0")
cd $script_dir/..

kubectl delete -f services/fib-quarkus/deploy
kubectl delete -f services/fib-go/deploy
kubectl delete -f services/fib-node/deploy
kubectl delete -f services/service.yaml 


kubectl delete -f frontend/deploy
 
kubectl delete -f haproxy/deploy
kubectl delete -f haproxy/deploy-openshift
 

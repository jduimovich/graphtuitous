@echo off
oc project  rgb

kubectl  delete -f services\fib-quarkus\deploy
kubectl delete -f services\fib-go\deploy
kubectl delete -f services\fib-node\deploy
kubectl delete -f services\service.yaml 
kubectl delete -f frontend\deploy
kubectl delete -f frontend\deploy-openshift

set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

oc project  rgb

kubectl delete -f services\fib-quarkus\deploy
kubectl delete -f services\fib-go\deploy
kubectl delete -f services\fib-node\deploy
kubectl delete -f services\service.yaml 


kubectl delete -f frontend\deploy
 
kubectl delete -f haproxy\deploy
kubectl delete -f haproxy\deploy-openshift
 

cd %CURRENT_DIR%
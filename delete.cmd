@echo off
oc project  rgb

oc delete -f services\fib-quarkus\deploy
oc delete -f services\fib-go\deploy
oc delete -f services\fib-node\deploy
oc delete -f services\service.yaml

oc delete -f frontend\deploy
oc delete -f frontend\deploy-openshift

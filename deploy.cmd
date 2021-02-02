@echo off
oc project  rgb

oc apply -f services\fib-quarkus\deploy
oc apply -f services\fib-go\deploy
oc apply -f services\fib-node\deploy
oc apply -f services\service.yaml

oc apply -f frontend\deploy
oc apply -f frontend\deploy-openshift

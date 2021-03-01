@echo off

set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..


oc project  rgb

oc apply -f services\fib-quarkus\deploy
oc apply -f services\fib-node\deploy
oc apply -f services\fib-go\deploy
oc apply -f services\service.yaml

oc apply -f frontend\deploy
 
oc apply -f haproxy\deploy
oc apply -f haproxy\deploy-openshift

cd %CURRENT_DIR%
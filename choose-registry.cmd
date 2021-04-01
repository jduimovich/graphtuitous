
@echo off

rem if using dockerhub 

set REGISTRY_USER=jduimovich
set REGISTRY=docker.io
set USE_DOCKER=true 
set REGISTRY_PASSWORD=%MY_DOCKER_PW%

rem if using quay 
rem set REGISTRY_USER=jduimovich0
rem set REGISTRY=quay.io
rem set USE_DOCKER=false 
rem set REGISTRY_PASSWORD=%MY_QUAY_PW% 

IF "%REGISTRY_PASSWORD%"=="" (GOTO :missing_reg_token) 

oc whoami --show-server >openshift.server
set /P SERVERQ=< openshift.server
del openshift.server
Set SERVER=%SERVERQ:"=%
rem echo  The server is /%SERVER%/
rem echo  The token is  /%LOGIN%/
 
yq w -i .github\workflows\build-all-and-deploy.yml env.REGISTRY %REGISTRY%/%REGISTRY_USER%
yq w -i .github\workflows\build-all-and-deploy.yml env.REGISTRY_USER %REGISTRY_USER%

yq r .github\workflows\build-all-and-deploy.yml env.REGISTRY 
yq r .github\workflows\build-all-and-deploy.yml env.REGISTRY_USER  

gh secret set OPENSHIFT_SERVER -b %SERVER%
gh secret set OPENSHIFT_TOKEN -b %LOGIN%
gh secret set REGISTRY_PASSWORD -b %REGISTRY_PASSWORD%
goto :end

:missing_reg_token
echo missing registry token - choose quay.io or docker.io

echo %REGISTRY_PASSWORD%
:end

@echo off

set REG=%1
IF "%REG%"=="" (GOTO :default_docker) 
IF "%REG%"=="docker.io" (GOTO :default_docker) 
IF "%REG%"=="quay.io" (GOTO :default_quay) 

:default_docker
set REGISTRY_USER=jduimovich
set REGISTRY=docker.io
set USE_DOCKER=true 
set REGISTRY_PASSWORD=%MY_DOCKER_PW%
goto :done_init

:default_quay 
set REGISTRY_USER=jduimovich0
set REGISTRY=quay.io
set USE_DOCKER=false 
set REGISTRY_PASSWORD=%MY_QUAY_PW% 
goto :done_init

:done_init
IF "%REGISTRY_PASSWORD%"=="" (GOTO :missing_reg_token) 

oc whoami --show-token >openshift.login.token
set /P LOGINQ=< openshift.login.token
del openshift.login.token
Set LOGIN=%LOGINQ:"=%

oc whoami --show-server >openshift.server
set /P SERVERQ=< openshift.server
del openshift.server
Set SERVER=%SERVERQ:"=%
rem echo  The server is /%SERVER%/
rem echo  The token is  /%LOGIN%/ 


set WORKFLOW=".github\workflows\build-and-update-gitops.yml"
 

yq -i e ".env.REGISTRY=\"%REGISTRY%/%REGISTRY_USER%\""  %WORKFLOW%
yq -i e ".env.REGISTRY_USER=\"%REGISTRY_USER%\""        %WORKFLOW% 
yq -i e ".env.REGISTRY_ROOT=\"%REGISTRY%\""             %WORKFLOW%

 
echo This app will be running on /%SERVER%/
echo Workflow is configured to the following registry, user and namespace
yq e ".env.REGISTRY" %WORKFLOW%
yq e ".env.REGISTRY_USER" %WORKFLOW% 
yq e ".env.REGISTRY_ROOT"   %WORKFLOW% 
yq e ".env.OPENSHIFT_NAMESPACE" %WORKFLOW%  

 
gh secret set OPENSHIFT_SERVER -b %SERVER%
gh secret set OPENSHIFT_TOKEN -b %LOGIN%
gh secret set REGISTRY_PASSWORD -b %REGISTRY_PASSWORD%
goto :end

:missing_reg_token
echo missing registry password - set env MY_DOCKER_PW pr MY_QUAY_PW before calling this script
:end
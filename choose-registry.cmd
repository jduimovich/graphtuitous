
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

 
yq w -i .github\workflows\build-all-and-deploy.yml env.REGISTRY %REGISTRY%/%REGISTRY_USER%
yq w -i .github\workflows\build-all-and-deploy.yml env.REGISTRY_USER %REGISTRY_USER%
yq w -i .github\workflows\build-all-and-deploy.yml env.REGISTRY_ROOT %REGISTRY%

echo This app will be running on /%SERVER%/
echo Workflow is configured to the following registry, user and namespace
yq r .github\workflows\build-all-and-deploy.yml env.REGISTRY 
yq r .github\workflows\build-all-and-deploy.yml env.REGISTRY_USER  
yq r .github\workflows\build-all-and-deploy.yml env.REGISTRY_ROOT 
yq r .github\workflows\build-all-and-deploy.yml env.OPENSHIFT_NAMESPACE  



gh secret set OPENSHIFT_SERVER -b %SERVER%
gh secret set OPENSHIFT_TOKEN -b %LOGIN%
gh secret set REGISTRY_PASSWORD -b %REGISTRY_PASSWORD%
goto :end

:missing_reg_token
echo missing registry password - set env MY_DOCKER_PW pr MY_QUAY_PW before calling this script
:end

@echo off
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
 
gh secret set OPENSHIFT_SERVER -b %SERVER%
gh secret set OPENSHIFT_TOKEN -b %LOGIN%
 
IF "%MY_QUAY_PW%"=="" (GOTO :missing_reg_token) 
gh secret set REGISTRY_PASSWORD -b %MY_QUAY_PW%
goto :end

:missing_reg_token
echo missing registry token in MY_DOCKER_PW

:end
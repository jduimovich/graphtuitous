@echo off

set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0 

oc apply -R -f %SCRIPT_DIR%\..\gitops  
 
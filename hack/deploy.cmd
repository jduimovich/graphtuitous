@echo off

set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

oc apply -R -f deploy  

cd %CURRENT_DIR%
@echo off

set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
oc new-project graphtuitous
oc project graphtuitous
oc apply -R -f %SCRIPT_DIR%\..\deploy   
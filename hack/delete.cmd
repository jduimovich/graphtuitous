set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..
  

kubectl delete -R -f deploy 

cd %CURRENT_DIR%
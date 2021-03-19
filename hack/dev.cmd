
 
set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

start services\fib-quarkus\dev.cmd
start services\fib-node\dev.cmd
start services\fib-go\dev.cmd
 
start services\frontend\dev.cmd 
start services\haproxy\dev.cmd 

start http://localhost:8888

cd %CURRENT_DIR%
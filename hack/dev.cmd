
 
set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

start /min services\fib-quarkus\dev.cmd
start /min services\fib-node\dev.cmd
start /min services\fib-go\dev.cmd
 
start /min services\frontend\dev.cmd 
start /min services\haproxy\dev.cmd 

start http://localhost:8888

cd %CURRENT_DIR%
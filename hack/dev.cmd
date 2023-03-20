
 
set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

start /min fib-quarkus\dev.cmd
start /min fib-node\dev.cmd
start /min fib-go\dev.cmd
 
start /min frontend\dev.cmd 
start /min haproxy\dev.cmd 

start http://localhost:8888

cd %CURRENT_DIR%
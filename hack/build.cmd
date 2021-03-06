
set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

cd services\fib-go
docker build -t jduimovich/fib-go .

cd ..\fib-node
docker build -t jduimovich/fib-node .

cd ..\fib-quarkus
call build-image.bat

cd ..\frontend
docker build -t jduimovich/frontend .

cd ..\haproxy
docker build -t jduimovich/haproxy .

docker push jduimovich/fib-go
docker push jduimovich/fib-node
docker push jduimovich/fib-quarkus
docker push jduimovich/frontend
docker push jduimovich/haproxy
  

cd %CURRENT_DIR%
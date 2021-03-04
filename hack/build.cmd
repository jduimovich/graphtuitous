
set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

cd services\fib-go
docker build -t jduimovich/fib-go .

cd ..\fib-node
docker build -t jduimovich/fib-node .

cd ..\fib-quarkus
call build-image.bat

cd ..\..\frontend
docker build -t jduimovich/frontend .
cd ..

cd haproxy
docker build -t jduimovich/frontend-haproxy .
cd ..

docker push jduimovich/fib-go
docker push jduimovich/fib-node
docker push jduimovich/fib-quarkus
docker push jduimovich/frontend
docker push jduimovich/frontend-haproxy
  

cd %CURRENT_DIR%
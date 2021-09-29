
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


docker login quay.io
docker tag jduimovich/fib-go quay.io/jduimovich0/fib-go 
docker tag jduimovich/fib-node quay.io/jduimovich0/fib-node 
docker tag jduimovich/fib-quarkus quay.io/jduimovich0/fib-quarkus 
docker tag jduimovich/frontend quay.io/jduimovich0/frontend
docker tag jduimovich/haproxy quay.io/jduimovich0/haproxy

docker push quay.io/jduimovich/fib-go
docker push quay.io/jduimovich/fib-node
docker push quay.io/jduimovich/fib-quarkus
docker push quay.io/jduimovich/frontend
docker push quay.io/jduimovich/haproxy


docker login docker.io
 
cd %CURRENT_DIR%
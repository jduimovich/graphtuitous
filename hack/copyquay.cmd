 
docker pull jduimovich/fib-go
docker pull jduimovich/fib-node
docker pull jduimovich/fib-quarkus
docker pull jduimovich/frontend
docker pull jduimovich/haproxy 

docker login quay.io
docker tag jduimovich/fib-go quay.io/jduimovich0/fib-go:demo 
docker tag jduimovich/fib-node quay.io/jduimovich0/fib-node:demo
docker tag jduimovich/fib-quarkus quay.io/jduimovich0/fib-quarkus:demo 
docker tag jduimovich/frontend quay.io/jduimovich0/frontend:demo
docker tag jduimovich/haproxy quay.io/jduimovich0/haproxy:demo

docker push quay.io/jduimovich0/fib-go:demo
docker push quay.io/jduimovich0/fib-node:demo
docker push quay.io/jduimovich0/fib-quarkus:demo
docker push quay.io/jduimovich0/frontend:demo
docker push quay.io/jduimovich0/haproxy:demo

docker login docker.io
 
cd %CURRENT_DIR%
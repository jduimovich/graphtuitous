docker build -t jduimovich/fib-go  .
docker stop fib-go
docker  run --rm --name fib-go -p 8080:8083 jduimovich/fib-go
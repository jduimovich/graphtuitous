call lbuild 
docker stop haproxy
docker rm haproxy
docker run  -it -p 8889:8080 --rm --name haproxy   jduimovich/frontend-haproxy-local
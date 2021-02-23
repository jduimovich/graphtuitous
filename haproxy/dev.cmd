call lbuild 
docker stop haproxy
docker rm haproxy
docker run  -it -p 8889:80 --rm --name haproxy   jduimovich/frontend-haproxy 
FROM docker.io/library/golang:alpine
WORKDIR /app
COPY . .  
RUN go env -w GO111MODULE=auto 
RUN go build -o /app/fib   
RUN chmod +x /app/fib
ENTRYPOINT ["/app/fib"]
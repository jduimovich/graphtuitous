FROM golang:alpine
WORKDIR /app
COPY . .  
RUN go build -o /app/fib   
ENTRYPOINT ["/app/fib"]
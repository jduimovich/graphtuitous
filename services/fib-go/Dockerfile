FROM golang:alpine
WORKDIR /app
COPY . .  

RUN ls -al  

RUN go env -w GO111MODULE=auto
RUN go build -o /app/fib   
ENTRYPOINT ["/app/fib"]
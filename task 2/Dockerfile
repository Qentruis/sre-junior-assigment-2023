FROM golang:1.20.7

WORKDIR /app

COPY go.mod main.go ./

RUN go build -o app

RUN rm /bin/sh

ENTRYPOINT ["./app"]
FROM golang:1.17-alpine
WORKDIR /srv
ADD . /srv
RUN go mod vendor && \
    go build -o bin/test-go-api internal/main.go
WORKDIR /srv
CMD ["./bin/test-go-api"]
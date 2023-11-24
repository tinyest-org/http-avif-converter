FROM golang:1.21-bullseye AS builder

RUN apt-get update && apt-get install libaom-dev -y

WORKDIR $GOPATH/src/http-avif-converter
COPY . .

RUN go mod download
RUN go mod verify

RUN CGO_ENABLED=1 GOOS=linux go build -o /http-server .

FROM alpine

COPY --from=builder /http-server /http-server

CMD ["/http-server"]

EXPOSE 8000

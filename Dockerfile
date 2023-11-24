FROM golang:1.21-alpine as builder

RUN apk add --no-cache gcc musl-dev aom-dev

WORKDIR $GOPATH/src/http-avif-converter
COPY . .

RUN go mod download
RUN go mod verify

RUN CGO_ENABLED=1 GOOS=linux go build -o /http-server .

FROM alpine
RUN apk add --no-cache aom-dev
COPY --from=builder /http-server /http-server

CMD ["/http-server"]

EXPOSE 8000

FROM golang:1.21-bullseye AS builder

RUN apt-get update && apt-get install libaom-dev -y

WORKDIR $GOPATH/src/http-avif-converter

COPY . .

RUN go mod download
RUN go mod verify

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main .

FROM gcr.io/distroless/static-debian11

COPY --from=builder /main .

# USER small-user:small-user

CMD ["./main"]

EXPOSE 8100

FROM golang:1.21-bullseye AS builder

# RUN apk add aom-dev aom-libs

RUN apt-get update && apt-get install libaom-dev

WORKDIR $GOPATH/src/http-avif-converter

COPY . .

RUN go mod download
RUN go mod verify

RUN go build -o /main .

FROM gcr.io/distroless/static-debian11

COPY --from=builder /main .

USER small-user:small-user

CMD ["./main"]

EXPOSE 8100
FROM golang:1.21-alpine AS builder

RUN apk add aom-dev

WORKDIR $GOPATH/src/smallest-golang/app/

COPY . .

RUN go mod download
RUN go mod verify

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main .

FROM gcr.io/distroless/static-debian11

COPY --from=builder /main .

USER small-user:small-user

CMD ["./main"]

EXPOSE 8100
FROM golang:1.21-bullseye AS builder

RUN apt-get update && apt-get install libaom-dev -y

WORKDIR /app
ENV GOPATH /app
COPY . /app/

RUN go mod download
RUN go mod verify
RUN CGO_ENABLED=1 GOOS=linux go build -o /main .

FROM alpine

COPY --from=build /main /main

CMD ["/main"]

EXPOSE 8000

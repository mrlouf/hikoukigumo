FROM golang:tip-alpine3.22@sha256:23896edb50a717e40dec51d85aebbdfe8da0a59ebe26ae8d45b4a4bcf91aed8f

COPY srcs/ .

WORKDIR /go/src/app

RUN go mod download

RUN go build -o main .

CMD ["./main"]
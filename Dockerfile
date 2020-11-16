FROM golang:alpine as builder
RUN export GO111MODULE=on
WORKDIR /app
RUN apk add git make gcc libc-dev
RUN git clone https://github.com/indes/flowerss-bot.git \
  && cd /app/flowerss-bot && make build

FROM alpine
RUN apk add ca-certificates
COPY --from=builder /app/flowerss-bot/flowerss-bot /bin/
VOLUME /root/.flowerss
WORKDIR /root/.flowerss
ENTRYPOINT ["/bin/flowerss-bot"]

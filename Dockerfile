FROM golang:alpine as builder

WORKDIR /app
RUN apk add git make gcc libc-dev 
RUN git clone https://github.com/indes/flowerss-bot.git && \
  cd /app/flowerss-bot && make build


FROM debian:stable-slim
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y ca-certificates \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
COPY --from=builder /app/flowerss-bot/flowerss-bot /bin/
VOLUME /root/.flowerss
WORKDIR /root/.flowerss
ENTRYPOINT ["flowerss-bot"]

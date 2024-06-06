FROM alpine:3.6

ENV PASSWORD        password
ENV METHOD          chacha20
ENV PROTOCOL        origin
ENV OBFS            http_simple
ENV REDIRECT        cloudflare.com

ARG BRANCH=manyuser


RUN apk --no-cache add python \
    libsodium \
    wget \
    libsodium \
    gettext


RUN wget -qO- --no-check-certificate https://github.com/shadowsocksr-backup/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C .

WORKDIR /shadowsocksr-${BRANCH}/shadowsocks

COPY config.json . 

RUN envsubst < config.json > config.json

CMD python server.py -c config.json

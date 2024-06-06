FROM alpine:3.6

ENV SERVER_PORT     12345
ENV PASSWORD        password
ENV METHOD          chacha20
ENV PROTOCOL        origin
ENV OBFS            http_simple

ARG BRANCH=manyuser
ARG WORK=/shadowsocksr-$BRANCH


RUN apk --no-cache add python \
    libsodium \
    wget


RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksr-backup/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C ${WORK}

COPY config.json ${WORK}/config.json

WORKDIR ${WORK}


EXPOSE $SERVER_PORT
CMD envsubst < config.json > config.json && \
    python ./shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS 

FROM alpine:3 AS builder
WORKDIR /app

ARG DNSCRYPT_VERSION=2.1.5

RUN wget https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/${DNSCRYPT_VERSION}/dnscrypt-proxy-linux_x86_64-${DNSCRYPT_VERSION}.tar.gz
RUN tar -xf dnscrypt-proxy*.tar.gz
RUN cp linux-x86_64/dnscrypt-proxy /app/

FROM alpine:3
WORKDIR /dnscrypt

COPY --from=builder /app/dnscrypt-proxy /dnscrypt/dnscrypt-proxy

EXPOSE 53/udp

CMD ./dnscrypt-proxy -config /dnscrypt/config/dnscrypt-proxy.toml
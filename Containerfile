FROM docker.io/library/alpine:latest

ENV OVPN_USER=
ENV OVPN_PASS=

RUN apk update && \
    apk upgrade --no-progress && \
    apk add --no-progress dumb-init dante-server openvpn openresolv && \
    mkdir -pv /etc/openvpn/clients && \
    rm -rfv /var/cache/apk/*

COPY sockd.conf /etc/sockd.conf
COPY ovpn-up /usr/local/sbin/ovpn-up
COPY entrypoint /usr/local/sbin/entrypoint

ENTRYPOINT ["/usr/bin/dumb-init"]

CMD /usr/local/sbin/entrypoint

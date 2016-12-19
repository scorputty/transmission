FROM alpine:latest

MAINTAINER scorputty
LABEL Description="Transmission" Vendor="Stef Corputty" Version="0.0.1"

RUN apk add --update \
    transmission-daemon \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /downloads \
  && mkdir -p /incomplete \
  && mkdir -p /etc/transmission-daemon

COPY src/ .

VOLUME ["/downloads"]
VOLUME ["/etc/transmission-daemon"]
VOLUME ["/incomplete"]

EXPOSE 9091 51413/tcp 51413/udp

ENV USERNAME admin
ENV PASSWORD transmission

RUN chmod +x /start-transmission.sh
CMD ["/start-transmission.sh"]

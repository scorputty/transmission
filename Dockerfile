FROM alpine:latest

MAINTAINER scorputty
LABEL Description="Transmission" Vendor="Stef Corputty" Version="0.0.1"

# variables
ENV appUser="media"
ENV appGroup="1000"
ENV USERNAME admin
ENV PASSWORD transmission


# mounted volumes should be mapped to media files and config with the run command
VOLUME ["/incomplete", "/downloads"]

# ports should be mapped with the run command to match your situation
EXPOSE 9091 51413/tcp 51413/udp

# copy the start script and config to the container
COPY src/ .

# install transmission
RUN apk add --update \
    transmission-daemon \
    && rm -rf /var/cache/apk/*

# user with access to media files and config
RUN adduser -D -u ${appGroup} ${appUser}

# switch to user media
USER ${appUser}

# create directories
RUN mkdir -p /downloads \
  && mkdir -p /incomplete \
  && mkdir -p /etc/transmission-daemon

# start application
CMD ["/start.sh"]

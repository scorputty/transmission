FROM alpine:edge

MAINTAINER scorputty
LABEL Description="Transmission" Vendor="Stef Corputty" Version="0.0.7"

# variables
ENV appUser="media"
ENV appGroup="media"
ENV PUID="10000"
ENV PGID="10000"
ENV USERNAME admin
ENV PASSWORD transmission

# ports should be mapped with the run command to match your situation
EXPOSE 9091 51413/tcp 51413/udp

# copy the start script and config to the container
COPY start.sh /start.sh

# copy default settings to /tmp
COPY settings.json /tmp/settings.json

# install transmission and su-exec (gosu)
RUN \
 apk --update add --no-cache \
 bash \
 su-exec \
 curl \
 transmission-cli \
 transmission-common \
 transmission-daemon && \
 rm -rf /var/cache/apk/*

# user with access to media files and config
RUN addgroup -g ${PGID} ${appGroup} && \
 adduser -G ${appGroup} -D -u ${PUID} ${appUser}

# create directories
RUN mkdir -p /share/config/transmission && touch /share/config/transmission/tag.txt

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /tmp/settings.json /share

# make sure start.sh is executable
RUN chmod u+x  /start.sh

# switch to user media
USER ${appUser}

# single mounted shared volume
VOLUME ["/share"]

# start application
CMD ["/start.sh"]

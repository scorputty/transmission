FROM alpine:latest

MAINTAINER scorputty
LABEL Description="Transmission" Vendor="Stef Corputty" Version="0.0.3"

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
COPY src/ .

# install transmission and su-exec (gosu)
RUN \
 apk --update add --no-cache \
 su-exec \
 transmission-daemon && \
 rm -rf /var/cache/apk/*

# create directories
RUN mkdir -p /downloads && \
 mkdir -p /incomplete && \
 mkdir -p /etc/transmission-daemon

# user with access to media files and config
RUN addgroup -g ${PGID} ${appGroup} && \
 adduser -G ${appGroup} -D -u ${PUID} ${appUser}

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /downloads /incomplete /etc/transmission-daemon

# permissions
RUN chmod u+x /start.sh

# switch to user media
USER ${appUser}

# start application
CMD ["/start.sh"]

#!/usr/bin/env bash

# edit for your situation
VOL_DOWNLOADS="/Volumes/shares/docker/data/transmission/downloads"
VOL_INCOMPLETE_DOWNLOADS="/Volumes/shares/docker/data/transmission/incomplete"
VOL_MEDIA="/Volumes/shares/docker/media"

test -d ${VOL_DOWNLOADS} || VOL_DOWNLOADS="${PWD}${VOL_DOWNLOADS}" && mkdir -p ${VOL_DOWNLOADS}
test -d ${VOL_INCOMPLETE_DOWNLOADS} || VOL_INCOMPLETE_DOWNLOADS="${PWD}${VOL_INCOMPLETE_DOWNLOADS}" && mkdir -p ${VOL_INCOMPLETE_DOWNLOADS}
test -d ${VOL_MEDIA} || VOL_MEDIA="${PWD}${VOL_MEDIA}" && mkdir -p ${VOL_MEDIA}

docker run -d -h $(hostname) \
    -e USER=media -e USERID=10000 \
    -p 9091:9091 \
    -p 51413:51413 \
    -p 51413:51413/udp \
    -v ${VOL_DOWNLOADS}:/downloads \
    -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete \
    -v ${VOL_MEDIA}:/media \
    -v /etc/localtime:/etc/timezone:ro \
    -e appUser=media \
    -e appGroup=media \
    -e PUID=10000 \
    -e PGID=10000 \
    --name=transmission --restart=always cryptout/transmission

  # for troubleshooting run
  # docker exec -it transmission /bin/bash
  # to check logs run
  # docker logs -f transmission
  # to change config run
  # docker run -ti cryptout/transmission vi /etc/transmission-daemon/settings.json

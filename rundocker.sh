#!/usr/bin/env bash

# edit for your situation
VOL_CONFIG="/Volumes/shares/docker/config/transmission"
VOL_DOWNLOADS="/Volumes/shares/docker/data/transmission/downloads"
VOL_INCOMPLETE_DOWNLOADS="/Volumes/shares/docker/data/transmission/incomplete"

test -d ${VOL_CONFIG} || VOL_CONFIG="${PWD}${VOL_CONFIG}" && mkdir -p ${VOL_CONFIG}
test -d ${VOL_DOWNLOADS} || VOL_DOWNLOADS="${PWD}${VOL_DOWNLOADS}" && mkdir -p ${VOL_DOWNLOADS}
test -d ${VOL_INCOMPLETE_DOWNLOADS} || VOL_DOWNLOADS="${PWD}${VOL_INCOMPLETE_DOWNLOADS}" && mkdir -p ${VOL_INCOMPLETE_DOWNLOADS}

docker run -d -h $(hostname) \
    -p 9091:9091 \
    -p 51314:51314 \
    -p 51314/udp:51314/udp \
    -v ${VOL_DOWNLOADS}:/downloads \
    -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete \
    -v ${VOL_CONFIG}:/etc/transmission-daemon \
    -e TZ=Europe/Amsterdam \
    -e PUID=1000 \
    -e PGID=1000 \
    --name=transmission --restart=always cryptout/transmission

  # for troubleshooting run
  # docker exec -it transmission /bin/bash
  # to check logs run
  # docker logs -f transmission

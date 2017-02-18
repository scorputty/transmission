#!/usr/bin/env bash

# edit for your situation (config/sickrage should be there)
VOL_SHARE="/Volumes/shares/docker/"

test -d ${VOL_SHARE} || VOL_SHARE="${PWD}${VOL_SHARE}" && mkdir -p ${VOL_SHARE}/config/transmission
test -d ${VOL_SHARE}/media/Downloads/transmission/complete || VOL_SHARE="${PWD}${VOL_SHARE}/media/Downloads/transmission/complete" && mkdir -p ${VOL_SHARE}/media/Downloads/transmission/complete
test -d ${VOL_SHARE}/media/Downloads/transmission/incomplete || VOL_SHARE="${PWD}${VOL_SHARE}/media/Downloads/transmission/incomplete" && mkdir -p ${VOL_SHARE}/media/Downloads/transmission/incomplete
test -d ${VOL_SHARE}/media/Downloads/transmission/watch || VOL_SHARE="${PWD}${VOL_SHARE}/media/Downloads/transmission/watch" && mkdir -p ${VOL_SHARE}/media/Downloads/transmission/watch

docker run -d -h $(hostname) \
    -e USER=media -e USERID=10000 \
    -p 9091:9091 \
    -p 51413:51413 \
    -p 51413:51413/udp \
    -v ${VOL_SHARE}:/share \
    -e appUser="media" \
    -e appGroup="media" \
    -e PUID="10000" \
    -e PGID="10000" \
    --name=transmission --restart=always cryptout/transmission

  # for troubleshooting run
  # docker exec -it transmission /bin/bash
  # to check logs run
  # docker logs -f transmission
  # to change config run
  # docker run -ti cryptout/transmission vi /etc/transmission-daemon/settings.json

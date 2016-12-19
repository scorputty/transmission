[![Build Status](https://travis-ci.org/scorputty/transmission.svg?branch=master)](https://travis-ci.org/scorputty/transmission) [![](https://images.microbadger.com/badges/image/cryptout/transmission.svg)](https://microbadger.com/images/cryptout/transmission "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/cryptout/transmission.svg)](https://microbadger.com/images/cryptout/transmission "Get your own version badge on microbadger.com")

# Docker transmission (Alpine)

This is a Dockerfile to set up "Transmission" - (https://transmissionbt.com/).

### Docker Hub
The built image is also hosted at Docker Hub - (https://hub.docker.com/r/cryptout/transmission/).
If you don't want to customize the container you can run it directly by typing the following commands.
```sh
export VOL_CONFIG="/Volumes/shares/docker/config/transmission"
export VOL_DOWNLOADS="/Volumes/shares/docker/data/transmission/downloads"
export VOL_INCOMPLETE_DOWNLOADS="/Volumes/shares/docker/data/transmission/incomplete"
export LOCAL_PORT1="9091"

docker run -d -h $(hostname) \
  -v ${VOL_CONFIG}:/config \
  -v ${VOL_DOWNLOADS}:/downloads \
  -v ${VOL_INCOMPLETE_DOWNLOADS}:/incomplete-downloads \
  -p ${LOCAL_PORT1}:9091 \
  -p 51413:51413 \
  -p 51413/udp:51413/udp \
  -e TZ=Europe/Amsterdam \
  -e PUID=1000 \
  -e PGID=1000 \
  --name=transmission --restart=always cryptout/transmission
```

# Build from Dockerfile
Clone this repository and run the build.sh script.
```sh
git clone https://github.com/scorputty/transmission.git
cd transmission
./build.sh
```

### Variables
Change to match your situation.
```Dockerfile
ENV appUser="media"
ENV appGroup="1000"
```

### Volumes
Make sure to map the Volumes to match your situation.
```Dockerfile
VOLUME ["/downloads"]
VOLUME ["/etc/transmission-daemon"]
VOLUME ["/incomplete"]
```

### To run the container
Edit rundocker.sh (this will be replaced by docker-compose soon...).
```sh
./rundocker.sh
```

### WebGUI
To reach the WebGUI go to - (http://localhost:9091).
Or replace localhost with your target IP. Login with admin/transmission.

## Info
* Shell access whilst the container is running: `docker exec -it transmission /bin/sh`
* To monitor the logs of the container in realtime: `docker logs -f transmission`

# Notes
I'm still learning Docker and use these private (pet)projects to develop my skills.
While I use these containers myself they are by no means perfect and are always prone to error or change.
That said, even if only one person copies a snippet of code or learns something from my projects I feel I've contributed a little bit to the Open-source cause...

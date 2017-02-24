[![Build Status](https://travis-ci.org/scorputty/transmission.svg?branch=master)](https://travis-ci.org/scorputty/transmission) [![](https://images.microbadger.com/badges/image/cryptout/transmission.svg)](https://microbadger.com/images/cryptout/transmission "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/cryptout/transmission.svg)](https://microbadger.com/images/cryptout/transmission "Get your own version badge on microbadger.com")

# Docker Transmission (Alpine)

This is a Dockerfile to build "Transmission" - (https://transmissionbt.com/).

### Docker Hub
The built image is also hosted at Docker Hub - (https://hub.docker.com/r/cryptout/transmission/).

# Build from Dockerfile
Clone this repository and run the build.sh script.
```sh
git clone https://github.com/scorputty/transmission.git
cd transmission
./build.sh
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

#!/bin/sh

set -e

# if /config doesnt exist, exit
test -d /incomplete || exit 1 && chown -R media /incomplete
# same goes for downloads
test -d /downloads || exit 2 && chown -R media /downloads

SETTINGS=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
	# Checks for USERNAME variable
	if [ -z "$USERNAME" ]; then
	  echo >&2 'Please set an USERNAME variable (ie.: -e USERNAME=admin).'
	  exit 1
	fi
	# Checks for PASSWORD variable
	if [ -z "$PASSWORD" ]; then
	  echo >&2 'Please set a PASSWORD variable (ie.: -e PASSWORD=transmission).'
	  exit 1
	fi
	# Modify settings.json
	sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS
	sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS
fi

unset PASSWORD USERNAME

exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon

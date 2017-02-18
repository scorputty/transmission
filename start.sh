#!/bin/sh

set -e

# /share/config maps to nfs share home-server/config
test -d /share/config/transmission || exit 1

SETTINGS=/share/config/transmission/settings.json

if [[ ! -f ${SETTINGS} ]]; then
	cp /tmp/settings.json ${SETTINGS}
fi

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

exec /usr/bin/transmission-daemon --foreground --config-dir /share/config/transmission

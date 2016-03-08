#!/usr/bin/env bash
source scripts/config_check.sh

respondInColor "${TXT_GREEN}" "Checking for $HOST_SERVICE instance"
PID=`check_pid`
respondInColor "${TXT_GREEN}" "Checking for another process running on port $PORT"
LIVE_PORT=`check_port`

if [ "$PID" == "" ] && [ "$LIVE_PORT" == "" ];
then
	checking_directory=`checkForDirectory "$WEB_DIRECTORY"`
	if [ "$checking_directory" == "" ];
	then
		if [ "$ACTIVE_SITE" == "false" ];
		then
			copyTemplate $TEMPLATE
		fi
	else
		while true; do
			read -p "Do you wish to copy web template ($TEMPLATE) over your current $WEB_DIRECTORY contents? [y/N]" yn
			case $yn in
				[Yy]* ) removeWeb; copyTemplate $TEMPLATE; break;;
				[Nn]* ) break;;
				* ) break;;
			esac
		done
	fi

	startService
	if [ "$NO_START" != "true" ];
	then
		startBrowser
	fi
else
	if [ "$PID" != "" ];
	then
		respondInColor "${TXT_RED}" "There is already an http-server instance running at $PROTOCOL://$HOST:$PORT"
	fi

	if [ "$LIVE_PORT" != "" ];
	then
		respondInColor "${TXT_RED}" "There is another service on port $PORT -> $LIVE_PORT"
	fi
fi

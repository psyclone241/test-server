#!/usr/bin/env bash
source scripts/config_check.sh

echo "Checking for http-server instance"
PID=`check_pid`
echo "Checking for another process running on port $PORT"
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
	startBrowser
else
	if [ "$PID" != "" ];
	then
		echo "There is already an http-server instance running at $PROTOCOL://$HOST:$PORT"
	fi

	if [ "$LIVE_PORT" != "" ];
	then
		echo "There is another service on port $PORT -> $LIVE_PORT"
	fi
fi

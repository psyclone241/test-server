#!/usr/bin/env bash
source config.ini
source scripts/functions.sh

checkForDirectory "$LOG_DIRECTORY"

echo "Checking for http-server instance"
PID=`check_pid`
echo "Checking for another process running on port $PORT"
LIVE_PORT=`check_port`

if [ "$PID" == "" ] && [ "$LIVE_PORT" == "" ];
then
	NPM_IS_INSTALLED=`program_is_installed npm`
	if [ "$NPM_IS_INSTALLED" == "1" ];
	then
		if [ -d "$NODE_DIRECTORY" ];
		then
			HTTP_SERVER_IS_INSTALLED=`npm_package_is_installed $NODE_DIRECTORY http-server`
			if [ "$HTTP_SERVER_IS_INSTALLED" == "1" ];
			then
				echo "Starting http-server instance at $PROTOCOL://$HOST:$PORT"
				if [ "$PROTOCOL" == "http" ];
				then
					FLAGS=""
				else
					FLAGS="-S"
				fi

				checkForDirectory "$WEB_DIRECTORY"

				makeLogEntry "start" "./$NODE_DIRECTORY/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY > $LOG_DIRECTORY/$LOG_FILE &"
				./$NODE_DIRECTORY/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY > $LOG_DIRECTORY/$LOG_FILE &

				if [ "$OPEN_BROWSER" == "true" ];
				then
					makeLogEntry "start" "python -mwebbrowser $PROTOCOL://$HOST:$PORT >/dev/null 2>&1"
					python -mwebbrowser $PROTOCOL://$HOST:$PORT >/dev/null 2>&1
				else
					echo "Your site is running, direct your browser to $PROTOCOL://$HOST:$PORT"
				fi
			else
				echo "You need to install the npm package http-server, npm install will install the requirements from package.json"
			fi
		else
			echo "There are no node modules installed here, perhaps you need to run, npm install"
		fi
	else
		echo 'You need to install npm'
	fi
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

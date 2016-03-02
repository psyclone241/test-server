#!/usr/bin/env bash
source scripts/config.ini
source scripts/functions.sh

if [ ! -d "$LOG_DIRECTORY" ];
then
	echo "Creating a logs directory at $LOG_DIRECTORY"
	mkdir $LOG_DIRECTORY
fi

echo "Checking for http-server instance on port $PORT"
PID=`bash scripts/check.sh $PORT`

NPM_IS_INSTALLED=`program_is_installed npm`

if [ "$NPM_IS_INSTALLED" == "1" ];
then

	if [ -d "$NODE_DIRECTORY" ];
	then
		HTTP_SERVER_IS_INSTALLED=`npm_package_is_installed $NODE_DIRECTORY http-server`
		if [ "$HTTP_SERVER_IS_INSTALLED" == "1" ];
		then
			if [ "$PID" == "" ];
			then
				echo "Starting http-server instance at $PROTOCOL://$HOST:$PORT"
				if [ "$PROTOCOL" == "http" ];
				then
					FLAGS=""
				else
					FLAGS="-S"
				fi
				./node_modules/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY > $LOG_DIRECTORY/$PROTOCOL.log &
			else
				echo "There is already an http-server instance running at $PROTOCOL://$HOST:$PORT"
			fi

			python -mwebbrowser $PROTOCOL://$HOST:$PORT >/dev/null 2>&1
		else
			echo "You need to install the npm package http-server, npm install will install the requirements from package.json"
		fi
	else
		echo "There are no node modules installed here, perhaps you need to run, npm install"
	fi
else
	echo 'You need to install npm'
fi

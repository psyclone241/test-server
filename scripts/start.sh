#!/usr/bin/env bash

# LOG_DIRECTORY='./logs'
# WEB_DIRECTORY='./web'
# PROTOCOL='http'
# HOST='localhost'
# PORT='9110'
# DIRECTORY_LISTING=false
# AUTO_INDEX=false

if [ ! -d "$LOG_DIRECTORY" ];
then
	echo "Creating a logs directory at $LOG_DIRECTORY"
	mkdir $LOG_DIRECTORY
fi

echo "Checking for http-server instance on port $PORT"
PID=`bash scripts/check.sh $PORT`

if [ "$PID" == "" ];
then
	echo "Starting http-server instance at $PROTOCOL://$HOST:$PORT"
	if [ "$PROTOCOL" == "http" ];
	then
		FLAGS=""
	else
		FLAGS="-S"
	fi
	http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY > $LOG_DIRECTORY/$PROTOCOL.log &
else
	echo "There is already an http-server instance running at $PROTOCOL://$HOST:$PORT"
fi

open $PROTOCOL://$HOST:$PORT

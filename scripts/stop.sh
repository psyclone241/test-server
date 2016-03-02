#!/usr/bin/env bash
source config.ini
source scripts/functions.sh

echo "Checking for http-server instance"
PID=`check_pid`
if [ "$PID" != "" ];
then
  echo "Killing http-server instance (PID: $PID) on port $PORT"
  kill $PID
else
  echo "No http-server instance on port $PORT"
fi

#!/usr/bin/env bash
source scripts/config_check.sh

echo "Checking for http-server instance"
PID=`check_pid`
if [ "$PID" != "" ];
then
  echo "Killing http-server instance (PID: $PID) on port $PORT"
  makeLogEntry "stop" "kill -9 $PID"
  kill -9 $PID
else
  echo "No http-server instance on port $PORT"
fi

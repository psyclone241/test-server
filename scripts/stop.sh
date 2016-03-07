#!/usr/bin/env bash
source scripts/config_check.sh

echo "Checking for http-server instance"
PID=`check_pid`
if [ "$PID" != "" ];
then
  echo "Killing http-server instance (PID: $PID) on port $PORT"
  stopService $PID
else
  echo "No http-server instance on port $PORT"
fi

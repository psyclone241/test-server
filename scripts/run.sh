#!/usr/bin/env bash
source config.ini
source scripts/functions.sh

if [ "$1" == "port" ];
then
  LIVE_PORT=`check_port`
  if [ "$LIVE_PORT" != "" ];
  then
    echo $LIVE_PORT
  else
    echo "No service running on $PORT"
  fi
fi

if [ "$1" == "pid" ];
then
  PID=`check_pid`
  if [ "$PID" != "" ];
  then
    echo $PID
  else
    echo "No http-server running"
  fi

fi

#!/usr/bin/env bash
if [ "$1" == "config" ];
then
  source scripts/functions.sh
else
  source scripts/config_check.sh
fi

if [ "$1" == "port" ];
then
  LIVE_PORT=`check_port`
  if [ "$LIVE_PORT" != "" ];
  then
    echo $LIVE_PORT
  else
    echo "No service running on $PORT"
  fi
elif [ "$1" == "pid" ];
then
  PID=`check_pid`
  if [ "$PID" != "" ];
  then
    echo $PID
  else
    echo "No http-server running"
  fi
elif [ "$1" == "config" ];
then
  if [ -f "config.ini" ];
  then
    echo 'Updating your config file'
  else
    echo 'Making a new config file'
  fi
else
  echo 'No command by that name'
fi

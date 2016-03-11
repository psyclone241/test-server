#!/usr/bin/env bash
source scripts/config_check.sh

respondInColor "${TXT_GREEN}" "Checking for $HOST_SERVICE instance"
PID=`check_pid`
if [ "$PID" != "" ];
then
  respondInColor "${TXT_GREEN}" "Killing $HOST_SERVICE instance (PID: $PID) on port $PORT"
  stopService $PID
else
  respondInColor "${TXT_RED}" "No $HOST_SERVICE instance on port $PORT"
fi

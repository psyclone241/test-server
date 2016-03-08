#!/usr/bin/env bash
source scripts/config_check.sh

respondInColor "${TXT_GREEN}" "Checking for http-server instance"
PID=`check_pid`
if [ "$PID" != "" ];
then
  respondInColor "${TXT_GREEN}" "Killing http-server instance (PID: $PID) on port $PORT"
  stopService $PID
else
  respondInColor "${TXT_RED}" "No http-server instance on port $PORT"
fi

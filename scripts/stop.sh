#!/usr/bin/env bash
PORT='9110'

echo "Checking for http-server instance on port $PORT"
PID=`bash scripts/check.sh $PORT`
if [ "$PID" != "" ];
then
  echo "Killing http-server instance (PID: $PID) on port $PORT"
  kill $PID
else
  echo "No http-server instance on port $PORT"
fi

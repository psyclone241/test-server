#!/usr/bin/env bash
command_chosen=$1

if [ "$command_chosen" == "config" ];
then
  source scripts/functions.sh
else
  source scripts/config_check.sh
fi

if [ "$command_chosen" == "port" ];
then
  LIVE_PORT=`check_port`
  if [ "$LIVE_PORT" != "" ];
  then
    respondInColor "${TXT_GREEN}" "$LIVE_PORT"
  else
    respondInColor "${TXT_RED}" "No service running on $PORT"
  fi
elif [ "$command_chosen" == "pid" ];
then
  PID=`check_pid`
  if [ "$PID" != "" ];
  then
    respondInColor "${TXT_GREEN}" "$PID"
  else
    respondInColor "${TXT_RED}" "No http-server running"
  fi
elif [ "$command_chosen" == "config" ] || [ "$command_chosen" == "testconfig" ];
then
  if [ "$command_chosen" == "config" ];
  then
    if [ -f "config.ini" ];
    then
      source scripts/config_check.sh
      respondInColor "${TXT_GREEN}" "Updating yourconfig file"
      respondInColor "${TXT_GREEN}" "TODO: Add master configuration editor"
    else
      echo "Making a new config file"
      cp config.ini.example config.ini
    fi
  else
    if [ -f "tests/config.ini" ];
    then
      respondInColor "${TXT_GREEN}" "Updating your tests/config file"
      respondInColor "${TXT_GREEN}" "TODO: Add test configuration editor"
    else
      echo "Making a new tests/config file"
      cp tests/config.ini.example tests/config.ini
    fi
  fi
else
  respondInColor "${TXT_RED}" "No command by that name"
fi

#!/usr/bin/env bash
if [ ! -f "config.ini" ];
then
  if [ "$SILENT" == "" ];
  then
    echo "Master Config - Check Failed"
    echo "There is no 'config.ini' in /"
    echo "RUN: 'make config'"
    echo "OR RUN: cp config.ini.example config.ini"
  fi
  exit
else
  if [ "$SILENT" == "" ];
  then
    echo "Master Config - Check Passed"
  fi
  source config.ini
  source scripts/functions.sh
  checkForDirectory "$LOG_DIRECTORY"
fi

#!/usr/bin/env bash
if [ ! -f "config.ini" ];
then
  if [ "$SILENT" == "" ];
  then
    respondInColor "${TXT_RED}" "Master Config - Check Failed"
    respondInColor "${TXT_RED}" "There is no 'config.ini' in /"
    respondInColor "${TXT_RED}" "RUN: 'make config'"
    respondInColor "${TXT_RED}" "OR RUN: cp config.ini.example config.ini"
  fi
  exit
else
  source config.ini
  source scripts/functions.sh
  checkForDirectory "$LOG_DIRECTORY"

  if [ "$SILENT" == "" ];
  then
    respondInColor "${TXT_GREEN}" "Master Config - Check Passed"
  fi
fi

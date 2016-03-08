#!/usr/bin/env bash
if [ ! -f "tests/config.ini" ];
then
  if [ "$SILENT" == "" ];
  then
    respondInColor "${TXT_RED}" "Test Config - Check Failed"
    respondInColor "${TXT_RED}" "There is no 'config.ini' in tests/"
    respondInColor "${TXT_RED}" "RUN: 'make testconfig'"
    respondInColor "${TXT_RED}" "OR RUN: cp tests/config.ini.example tests/config.ini"
  fi
  exit
else
  source tests/config.ini
  source scripts/functions.sh
  checkForDirectory "$LOG_DIRECTORY"

  if [ "$SILENT" == "" ];
  then
    respondInColor "${TXT_GREEN}" "Test Config - Check Passed"
  fi
fi

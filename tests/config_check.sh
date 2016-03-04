#!/usr/bin/env bash
if [ ! -f "tests/config.ini" ];
then
  if [ "$SILENT" == "" ];
  then
    echo "Test Config - Check Failed"
    echo "There is no 'config.ini' in tests/"
    echo "RUN: 'make testconfig'"
    echo "OR RUN: cp tests/config.ini.example tests/config.ini"
  fi
  exit
else
  if [ "$SILENT" == "" ];
  then
    echo "Test Config - Check Passed"
  fi
  source tests/config.ini
  source tests/functions.sh
fi

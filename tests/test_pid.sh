#!/usr/bin/env bash
if [ ! -f "config.ini" ];
then
  echo "Master Configuration missing in tests"
  echo "Try: cp config.ini.example config.ini"
  exit
fi

if [ ! -f "tests/config.ini" ];
then
  echo "Test Configuration missing in tests"
  echo "Try: cp tests/config.ini.example tests/config.ini"
  exit
fi

source config.ini
source tests/config.ini
source tests/functions.sh
source scripts/functions.sh

pid=`check_pid`
test="Checking for active process [http-server]"
if [ "$pid" != "" ];
then
  respondInColor "$test" "3"
else
  respondInColor "$test" "2"
fi

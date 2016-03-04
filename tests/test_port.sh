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

port=`check_port`
test="Checking for active port [$PORT]"
if [ "$port" != "" ];
then
  respondInColor "$test" "3"
else
  respondInColor "$test" "2"
fi

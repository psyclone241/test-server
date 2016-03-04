#!/usr/bin/env bash
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

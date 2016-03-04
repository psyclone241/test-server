#!/usr/bin/env bash
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

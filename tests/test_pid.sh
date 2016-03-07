#!/usr/bin/env bash
source scripts/config_check.sh
source tests/config_check.sh

pid=`check_pid`
test="Checking for active process [$HOST_SERVICE]"
if [ "$pid" != "" ];
then
  respondInColor "$test" "3"
else
  respondInColor "$test" "2"
fi

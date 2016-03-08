#!/usr/bin/env bash
source scripts/config_check.sh
source tests/config_check.sh

pid=`check_pid`
test="Checking for active process [$HOST_SERVICE]"
if [ "$pid" != "" ];
then
  statusResponse "$test" "3"
else
  statusResponse "$test" "2"
fi

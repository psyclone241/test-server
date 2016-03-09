#!/usr/bin/env bash
source scripts/config_check.sh
source tests/config_check.sh

pid=`check_pid`
test="Active process [$HOST_SERVICE]"
makeLine
respondInColor "${TXT_BLUE}" "CHECKING DEFINED PROCESS"
makeLine
if [ "$pid" != "" ];
then
  statusResponse "$test" "3"
else
  statusResponse "$test" "2"
fi

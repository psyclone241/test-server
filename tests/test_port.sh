#!/usr/bin/env bash
source scripts/config_check.sh
source tests/config_check.sh

port=`check_port`
test="Checking for active port [$PORT]"
if [ "$port" != "" ];
then
  statusResponse "$test" "3"
else
  statusResponse "$test" "2"
fi

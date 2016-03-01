#!/usr/bin/env bash
PORT=$1
if [ "$PORT" != "" ];
then
  ps aux | grep "[h]ttp-server" | awk '{print $2}'
fi

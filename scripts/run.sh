#!/usr/bin/env bash
source config.ini
source scripts/functions.sh

if [ "$1" == "port" ];
then
  check_port
fi

if [ "$1" == "pid" ];
then
  check_pid
fi

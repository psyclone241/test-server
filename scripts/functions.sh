#!/usr/bin/env bash

function program_is_installed {
  local return_=1
  type $1 >/dev/null 2>&1 || { local return_=0; }
  echo "$return_"
}

function npm_package_is_installed {
  local return_=1
  ls $1 | grep $2 >/dev/null 2>&1 || { local return_=0; }
  echo "$return_"
}

function check_pid {
    PID=`ps aux | grep "[h]ttp-server" | awk '{print $2}'`
    if [ "$PID" != "" ];
    then
      echo $PID
    fi
}

function check_port {
  if [ "$PORT" != "" ];
  then
    OPEN_PORT=`netstat -lnt | grep $PORT | awk '{print $4}'`
    echo $OPEN_PORT
  fi
}

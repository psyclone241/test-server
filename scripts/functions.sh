#!/usr/bin/env bash

function program_is_installed {
  makeLogEntry "program_is_installed" "type $1 >/dev/null 2>&1 || { local return_=0; }"
  local return_=1
  type $1 >/dev/null 2>&1 || { local return_=0; }
  echo "$return_"
}

function npm_package_is_installed {
  makeLogEntry "npm_package_is_installed" "ls $1 | grep $2 >/dev/null 2>&1 || { local return_=0; }"
  local return_=1
  ls $1 | grep $2 >/dev/null 2>&1 || { local return_=0; }
  echo "$return_"
}

function check_pid {
    makeLogEntry "check_pid" "ps aux | grep "[h]ttp-server" | awk '{print $2}'"
    PID=`ps aux | grep "[h]ttp-server" | awk '{print $2}'`
    if [ "$PID" != "" ];
    then
      echo $PID
    fi
}

function check_port {
  if [ "$PORT" != "" ];
  then
    makeLogEntry "check_port" "netstat -lnt | grep $PORT | awk '{print $4}'"
    OPEN_PORT=`netstat -lnt | grep $PORT | awk '{print $4}'`
    echo $OPEN_PORT
  fi
}

function checkForDirectory {
  if [ ! -d "$1" ];
  then
  	echo "Creating a directory at $1"
  	makeLogEntry "checkForDirectory" "mkdir -p $1"
  	mkdir -p $1
  fi
}

function makeLogEntry {
  date=`date +"%Y%m%d%H%M%S"`
  echo -e "[$date]\t\t[$1]\t\t$2" >> $LOG_DIRECTORY/$APP_LOG_FILE
}

function copyTemplate {
  cp -R ./templates/$1/* $WEB_DIRECTORY/
}

function removeWeb {
  while true; do
    read -p "Removing files from $WEB_DIRECTORY/*, continue? [y/N]" yn
    case $yn in
      [Yy]* ) rm -fR $WEB_DIRECTORY/*; break;;
      [Nn]* ) break;;
      * ) break;;
    esac
  done
}

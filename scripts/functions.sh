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

function checkForLogDirectory {
  if [ ! -d "$LOG_DIRECTORY" ];
  then
  	echo "Creating a logs directory at $LOG_DIRECTORY"
  	logEntry "checkForLogDirectory" "mkdir $LOG_DIRECTORY"
  	mkdir $LOG_DIRECTORY
  fi
}

function makeLogEntry {
  checkForLogDirectory
  date=`date +"%Y%m%d%H%M%S"`
  echo -e "[$date]\t\t[$1]\t\t$2" >> $LOG_DIRECTORY/$APP_LOG_FILE
}

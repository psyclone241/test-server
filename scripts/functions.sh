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
  if [ "$HOST_SERVICE" == "http-server" ];
  then
    makeLogEntry "check_pid" "ps aux | grep "[h]ttp-server" | awk '{print $2}'"
    PID=`ps aux | grep "[h]ttp-server" | awk '{print $2}'`
    if [ "$PID" != "" ];
    then
      echo $PID
    fi
  elif [ "$HOST_SERVICE" == "pythonSimpleHTTPServer" ];
  then
    makeLogEntry "check_pid" "ps aux | grep "[S]impleHTTPServer" | awk '{print $2}'"
    PID=`ps aux | grep "[S]impleHTTPServer" | awk '{print $2}'`
    if [ "$PID" != "" ];
    then
      echo $PID
    fi
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
  	mkdir -p $1
    makeLogEntry "checkForDirectory" "mkdir -p $1"
  fi
}

function checkForFile {
  if [ ! -f "$1" ];
  then
  	echo "Creating a file at $1"
  	touch $1
    makeLogEntry "checkForFile" "touch $1"
  fi
}

function makeLogEntry {
  checkForDirectory "$LOG_DIRECTORY"
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

function startBrowser {
  this_site="$PROTOCOL://$HOST:$PORT"
  if [ "$OPEN_BROWSER" == "true" ];
	then
    echo "Starting browser to view your site at $this_site"
    makeLogEntry "start" "python -mwebbrowser $his_site >/dev/null 2>&1"
    python -m webbrowser $this_site >/dev/null 2>&1
	else
		echo "Your site is running, direct your browser to $this_site"
	fi
}

function startService {
  checkForDirectory $LOG_DIRECTORY
  checkForFile $LOG_DIRECTORY/$LOG_FILE

  if [ "$HOST_SERVICE" == "http-server" ];
  then
    NPM_IS_INSTALLED=`program_is_installed npm`
  	if [ "$NPM_IS_INSTALLED" == "1" ];
  	then
  		if [ -d "$NODE_DIRECTORY" ];
  		then
  			HTTP_SERVER_IS_INSTALLED=`npm_package_is_installed $NODE_DIRECTORY http-server`
  			if [ "$HTTP_SERVER_IS_INSTALLED" == "1" ];
  			then
  				echo "Starting http-server instance at $PROTOCOL://$HOST:$PORT"
  				if [ "$PROTOCOL" == "http" ];
  				then
  					FLAGS=""
  				else
  					FLAGS="-S"
  				fi

          makeLogEntry "start" "./$NODE_DIRECTORY/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY > $LOG_DIRECTORY/$LOG_FILE &"
          ./$NODE_DIRECTORY/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY >> $LOG_DIRECTORY/$LOG_FILE &
  			else
  				echo "You need to install the npm package http-server, npm install will install the requirements from package.json"
  			fi
  		else
  			echo "There are no node modules installed here, perhaps you need to run, npm install"
  		fi
  	else
  		echo 'You need to install npm'
  	fi
  elif [ "$HOST_SERVICE" == "pythonSimpleHTTPServer" ];
  then
    makeLogEntry "start" "cd $WEB_DIRECTORY; python -m SimpleHTTPServer $PORT > $LOG_DIRECTORY/$LOG_FILE 2>&1"
    cd $WEB_DIRECTORY
    python -m SimpleHTTPServer $PORT > /dev/null 2>&1 &
  else
    echo "No service type was chosen, or selected option [$HOST_SERVICE] is not currently supported"
  fi
}

function stopService {
  makeLogEntry "stop" "kill -9 $PID"
  kill -9 $1
}

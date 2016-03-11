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
  elif [ "$HOST_SERVICE" == "harp" ];
  then
    makeLogEntry "check_pid" "ps aux | grep "[h]arp" | awk '{print $2}'"
    PID=`ps aux | grep "[h]arp" | awk '{print $2}'`
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
  	respondInColor "${TXT_GREEN}" "Creating a directory at $1"
  	mkdir -p $1
    makeLogEntry "checkForDirectory" "mkdir -p $1"
  fi
}

function checkForFile {
  if [ ! -f "$1" ];
  then
  	respondInColor "${TXT_GREEN}" "Creating a file at $1"
  	touch $1
    makeLogEntry "checkForFile" "touch $1"
  fi
}

function makeLogEntry {
  date=`date +"%Y%m%d%H%M%S"`
  echo -e "[$date]\t\t[$1]\t\t$2" >> $APP_LOG_FILE
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
  if [ "$1" != "" ];
  then
    this_site=$1
  else
    this_site="$PROTOCOL://$HOST:$PORT"
  fi

  if [ "$OPEN_BROWSER" == "true" ];
	then
    respondInColor "${TXT_GREEN}" "Pointing your default web browser to $this_site"
    makeLogEntry "start" "python -mwebbrowser $this_site >/dev/null 2>&1"
    python -m webbrowser $this_site >/dev/null 2>&1
	else
		respondInColor "${TXT_GREEN}" "Your site is running, direct your browser to $this_site"
	fi
}

function startService {
  if [ "$HOST_SERVICE" == "http-server" ] || [ "$HOST_SERVICE" == "harp" ];
  then
    NPM_IS_INSTALLED=`program_is_installed npm`
  	if [ "$NPM_IS_INSTALLED" == "1" ];
  	then
  		if [ -d "$NODE_DIRECTORY" ];
  		then
  			NODE_TYPE_SERVER_IS_INSTALLED=`npm_package_is_installed $NODE_DIRECTORY $HOST_SERVICE`
  			if [ "$NODE_TYPE_SERVER_IS_INSTALLED" == "1" ];
  			then
  				respondInColor "${TXT_GREEN}" "Starting $HOST_SERVICE instance at $PROTOCOL://$HOST:$PORT"
  				if [ "$PROTOCOL" == "http" ];
  				then
  					FLAGS=""
  				else
  					FLAGS="-S"
  				fi

          if [ "$HOST_SERVICE" == "http-server" ];
          then
            makeLogEntry "start" "./$NODE_DIRECTORY/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY > $LOG_DIRECTORY/$LOG_FILE &"
            ./$NODE_DIRECTORY/http-server/bin/http-server $FLAGS -d $DIRECTORY_LISTING -i $AUTO_INDEX -p $PORT $WEB_DIRECTORY >> $LOG_FILE &
          elif [ "$HOST_SERVICE" == "harp" ];
          then
            makeLogEntry "start" "./$NODE_DIRECTORY/harp/bin/harp server $WEB_DIRECTORY --port $PORT > $LOG_DIRECTORY/$LOG_FILE &"
            ./$NODE_DIRECTORY/harp/bin/harp server $WEB_DIRECTORY --port $PORT >> $LOG_FILE &
          fi
  			else
  				respondInColor "${TXT_RED}" "You need to install the npm package $HOST_SERVICE, npm install will install the requirements from package.json"
          NO_START=true
  			fi
  		else
  			respondInColor "${TXT_RED}" "There are no node modules installed here, perhaps you need to run, npm install"
        NO_START=true
  		fi
  	else
  		respondInColor "${TXT_RED}" "You need to install npm"
      NO_START=true
  	fi
  elif [ "$HOST_SERVICE" == "pythonSimpleHTTPServer" ];
  then
    makeLogEntry "start" "cd $WEB_DIRECTORY; python -m SimpleHTTPServer $PORT > $LOG_FILE 2>&1"
    cd $WEB_DIRECTORY
    python -m SimpleHTTPServer $PORT > /dev/null 2>&1 &
  else
    respondInColor "${TXT_RED}" "No service type was chosen, or selected option [$HOST_SERVICE] is not currently supported"
  fi
}

function stopService {
  makeLogEntry "stop" "kill -9 $PID"
  kill -9 $1
}

function statusResponse {
  if [ "$2" == "1" ] || [ "$2" == "2" ];
  then
    color=${TXT_GREEN}
    if [ "$2" == "1" ];
    then
      status="passed"
    else
      status="inactive"
    fi
  else
    color=${TXT_RED}
    if [ "$2" == "0" ];
    then
      status="failed"
    else
      status="active"
    fi
  fi

  string1="${1}"
  string2=`respondInColor "$color" "[$status]"`
  printf "%-*s%*s\n" "$COL1" "$string1" "$COL2" "$string2"
}

function respond {
  echo -e "$1"
}

function makeLine {
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function respondInColor {
  echo -e "${1}$2${TXT_RESET}"
}

function checkValue {
  if [ "$1" != "" ];
  then
    if [ "$2" == "dir" ];
    then
      if [ -d "$1" ];
      then
        echo "1"
      else
        echo "0"
      fi
    elif [ "$2" == "file" ];
    then
      if [ -f "$1" ];
      then
        echo "1"
      else
        echo "0"
      fi
    else
      echo "1"
    fi
  else
    echo "0"
  fi
}

function getIndex() {
	index=0; while ((index<${#ARRAY[*]})); do
		if [ "${ARRAY[$index]}" = "$1" ]; then
			echo $index; return
		fi
	((index++)); done
	echo 'Not Found'; return 1
}

function configCheckLoop {
  if [ "${#check_array[@]}" != "0" ];
  then
    makeLine
    respondInColor "${TXT_BLUE}" "CHECKING $check_title"
    makeLine
    for config_variable in "${check_array[@]}"
    do
      value=`eval echo '${'$config_variable'}'`
      ARRAY=(${directory_values[@]})
      is_directory=`getIndex "$config_variable"`
      ARRAY=(${file_values[@]})
      is_file=`getIndex "$config_variable"`

      if [ "$is_directory" != 'Not Found' ];
      then
        check=`checkValue "$value" "dir"`
        statusResponse "${testing_text}${config_variable} [${value}]" "$check"
      fi

      if [ "$is_file" != 'Not Found' ];
      then
        check=`checkValue "$value" "file"`
        statusResponse "${testing_text}${config_variable} [${value}]" "$check"
      fi

      if [ "$is_file" == 'Not Found' ] && [ "$is_directory" == 'Not Found' ];
      then
        check=`checkValue "$value"`
        statusResponse "${testing_text}${config_variable} [${value}]" "$check"
      fi
    done
  else
    respondInColor "${TXT_ORANGE}" "NO ITEMS IN $check_title"
  fi
}

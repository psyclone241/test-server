#!/usr/bin/env bash
source scripts/config_check.sh
source tests/config_check.sh

makeLine
respondInColor "${TXT_BLUE}" "CHECKING DEFINED SERVICE"
makeLine
if [ "$HOST_SERVICE" == "http-server" ];
then
  NPM_IS_INSTALLED=`program_is_installed npm`
  npm_test="Installation of [npm]"
  if [ "$NPM_IS_INSTALLED" == "1" ];
  then
    statusResponse "${npm_test}" "$NPM_IS_INSTALLED"
    directory_test="Node directory [$NODE_DIRECTORY]"
    if [ -d "$NODE_DIRECTORY" ];
    then
      statusResponse "${directory_test}" "1"
      HTTP_SERVER_IS_INSTALLED=`npm_package_is_installed $NODE_DIRECTORY http-server`
      http_server_test="Installation of [http-server]"
      if [ "$HTTP_SERVER_IS_INSTALLED" == "1" ];
      then
        statusResponse "${http_server_test}" "$HTTP_SERVER_IS_INSTALLED"
      else
        statusResponse "${http_server_test}" "$HTTP_SERVER_IS_INSTALLED"
      fi
    else
      statusResponse "${directory_test}" "0"
    fi
  else
    statusResponse "${npm_test}" "$NPM_IS_INSTALLED"
  fi
elif [ "$HOST_SERVICE" == "pythonSimpleHTTPServer" ];
then
  PYTHON_IS_INSTALLED=`program_is_installed pyton`
  statusResponse "Installation of python" "$PYTHON_IS_INSTALLED"
else
  statusResponse "Missing HOST_SERVICE or invalid [$HOST_SERVICE]" "0"
fi

#!/usr/bin/env bash
source tests/config_check.sh
test="Configuration File [$CONFIG_FILE]"
testing_text="Checking setting: "
if [ -f "$CONFIG_FILE" ];
then
  source config.ini
  respondInColor "${TXT_BLUE}" "LOADING CONFIGURATION FILE"
  statusResponse "$test" "1"

  directory_values=( 'LOG_DIRECTORY' 'WEB_DIRECTORY' 'NODE_DIRECTORY' )
  file_values=( 'LOG_FILE' 'APP_LOG_FILE' )
  required_values=( 'LOG_DIRECTORY' 'LOG_FILE' 'APP_LOG_FILE' 'WEB_DIRECTORY' 'ACTIVE_SITE' 'TEMPLATE' 'PROTOCOL' 'HOST' 'PORT' 'HOST_SERVICE' )
  optional_values=( 'DIRECTORY_LISTING' 'AUTO_INDEX' 'OPEN_BROWSER' )
  conditional_values=( 'NODE_DIRECTORY' )

  check_title="REQUIRED CONFIGURATION"
  check_array=(${required_values[@]})
  configCheckLoop

  check_title="OPTIONAL CONFIGURATION"
  check_array=(${optional_values[@]})
  configCheckLoop

  check_title="CONDITIONAL CONFIGURATION"
  check_array=(${conditional_values[@]})
  configCheckLoop
else
  # Code for Success (green) Text
  TXT_GREEN=$(tput setaf 2)
  # Code for Danger (red) Text
  TXT_RED=$(tput setaf 1)
  # Code for Information (cyan) Text
  TXT_BLUE=$(tput setaf 6)
  # Code for Warning (orange) Text
  TXT_ORANGE=$(tput setaf 3)
  # Code for resetting the color after use
  TXT_RESET=$(tput sgr0)
  statusResponse "$test" "0"
fi

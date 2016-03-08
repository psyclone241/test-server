#!/usr/bin/env bash
source tests/config_check.sh

test="Configuration File [$CONFIG_FILE]"
if [ -f "$CONFIG_FILE" ];
then
  respondInColor "$test" "1"
  source config.ini

  check=`checkValue "$LOG_DIRECTORY" "dir"`
  statusResponse "Checking LOG_DIRECTORY [$LOG_DIRECTORY]" "$check"

  check=`checkValue "$LOG_DIRECTORY/$LOG_FILE" "file"`
  statusResponse "Checking LOG_FILE [$LOG_DIRECTORY/$LOG_FILE]" "$check"

  check=`checkValue "$LOG_DIRECTORY/$APP_LOG_FILE" "file"`
  statusResponse "Checking APP_LOG_FILE [$LOG_DIRECTORY/$APP_LOG_FILE]" "$check"

  check=`checkValue "$WEB_DIRECTORY"`
  statusResponse "Checking WEB_DIRECTORY [$WEB_DIRECTORY]" "$check"

  check=`checkValue "$ACTIVE_SITE"`
  statusResponse "Checking ACTIVE_SITE [$ACTIVE_SITE]" "$check"

  check=`checkValue "$TEMPLATE"`
  statusResponse "Checking TEMPLATE [$TEMPLATE]" "$check"

  check=`checkValue "$NODE_DIRECTORY"`
  statusResponse "Checking NODE_DIRECTORY [$NODE_DIRECTORY]" "$check"

  check=`checkValue "$PROTOCOL"`
  statusResponse "Checking PROTOCOL [$PROTOCOL]" "$check"

  check=`checkValue "$HOST"`
  statusResponse "Checking HOST [$HOST]" "$check"

  check=`checkValue "$PORT"`
  statusResponse "Checking PORT [$PORT]" "$check"

  check=`checkValue "$DIRECTORY_LISTING"`
  statusResponse "Checking DIRECTORY_LISTING [$DIRECTORY_LISTING]" "$check"

  check=`checkValue "$AUTO_INDEX"`
  statusResponse "Checking AUTO_INDEX [$AUTO_INDEX]" "$check"

  check=`checkValue "$OPEN_BROWSER"`
  statusResponse "Checking OPEN_BROWSER [$OPEN_BROWSER]" "$check"
else
  statusResponse "$test" "0"
fi

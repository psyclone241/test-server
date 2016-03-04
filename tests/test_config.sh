#!/usr/bin/env bash
source tests/config.ini
source tests/functions.sh

test="Configuration File [$CONFIG_FILE]"
if [ -f "$CONFIG_FILE" ];
then
  respondInColor "$test" "1"
  source config.ini

  check=`checkValue "$LOG_DIRECTORY"`
  respondInColor "Checking LOG_DIRECTORY [$LOG_DIRECTORY]" "$check"

  check=`checkValue "$LOG_FILE"`
  respondInColor "Checking LOG_FILE [$LOG_FILE]" "$check"

  check=`checkValue "$APP_LOG_FILE"`
  respondInColor "Checking APP_LOG_FILE [$APP_LOG_FILE]" "$check"

  check=`checkValue "$WEB_DIRECTORY"`
  respondInColor "Checking WEB_DIRECTORY [$WEB_DIRECTORY]" "$check"

  check=`checkValue "$ACTIVE_SITE"`
  respondInColor "Checking ACTIVE_SITE [$ACTIVE_SITE]" "$check"

  check=`checkValue "$TEMPLATE"`
  respondInColor "Checking TEMPLATE [$TEMPLATE]" "$check"

  check=`checkValue "$NODE_DIRECTORY"`
  respondInColor "Checking NODE_DIRECTORY [$NODE_DIRECTORY]" "$check"

  check=`checkValue "$PROTOCOL"`
  respondInColor "Checking PROTOCOL [$PROTOCOL]" "$check"

  check=`checkValue "$HOST"`
  respondInColor "Checking HOST [$HOST]" "$check"

  check=`checkValue "$PORT"`
  respondInColor "Checking PORT [$PORT]" "$check"

  check=`checkValue "$DIRECTORY_LISTING"`
  respondInColor "Checking DIRECTORY_LISTING [$DIRECTORY_LISTING]" "$check"

  check=`checkValue "$AUTO_INDEX"`
  respondInColor "Checking AUTO_INDEX [$AUTO_INDEX]" "$check"

  check=`checkValue "$OPEN_BROWSER"`
  respondInColor "Checking OPEN_BROWSER [$OPEN_BROWSER]" "$check"
else
  respondInColor "$test" "0"
fi

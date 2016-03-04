#!/usr/bin/env bash
function respondInColor {
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
    if [ "$2" == "1" ];
    then
      status="failed"
    else
      status="active"
    fi
  fi

  string1="${1}"
  string2="[${color}$status${TXT_RESET}]"
  printf "%-*s%*s\n" "$COL1" "$string1" "$COL2" "$string2"
}

function checkValue {
  if [ "$1" != "" ];
  then
    echo "1"
  else
    echo "0"
  fi
}

#!/usr/bin/env bash

function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

function npm_package_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  ls $1 | grep $2 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

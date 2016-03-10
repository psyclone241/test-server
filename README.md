# Introduction
Just a little test project, implementing the node project, http-server by default,
but it can also be used to setup a test service with the python SimpleHTTPServer

# Requirements (if default http-server used)
* npm
* npm packages:
  * http-server
* make

# Requirements (if python service used)
* make
* python (version >= 2.7)

# Installation (if default http-server used)
$ npm install

# Installation (if python service used)
* There is no pre-use install for this option

# Configuration
* Copy config.ini.example to config.ini
$ cp config.ini.example config.ini
* Edit your new config.ini file for your preferences

# Usage
* Show your options
  $ make
* Configure your server or create a new config
  $ make config
* Configure your test suite or create a new test config
  $ make testconfig
* Run your server
  $ make start
* Stop your server
  $ make stop
* Restart your server
  $ make restart
* Show the PID for the active server
  $ make pid
* Show any service on the port specified in config.ini
  $ make port
* Open the default browser with python, to your server
  $ make browse

# Testing
* Run full test suite
  $ make test

# TODO List
* Make configuration editor inside of 'make config'
* Make configuration editor inside of 'make testconfig'
* Add testing for each individual method, so that they can be run
independent of 'make test'

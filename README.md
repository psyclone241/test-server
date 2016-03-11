# Introduction

Just a little test project, to be able to quickly serve HTML or Markdown, using
a number of node based tools, or simply using python's SimpleHTTPServer.

# Requirements (if default http-server used)

  * npm
  * npm packages:
    * http-server
  * make

# Requirements (if harp used)

  * npm
  * npm packages:
    * harp
  * make

# Requirements (if python service used)

  * make
  * python (version >= 2.7)

# Installation (if default http-server used)

  * <pre>$ npm install</pre>

# Installation (if harp used)

  * <pre>$ npm install</pre>

# Installation (if python service used)

  * There is no pre-use install for this option

# Configuration

  * Copy config.ini.example to config.ini
  $ cp config.ini.example config.ini
  * Edit your new config.ini file for your preferences

# Usage

  * Show your options
    <pre>$ make</pre>
  * Configure your server or create a new config
    <pre>$ make config</pre>
  * Configure your test suite or create a new test config
    <pre>$ make testconfig</pre>
  * Run your server
    <pre>$ make start</pre>
  * Stop your server
    <pre>$ make stop</pre>
  * Restart your server
    <pre>$ make restart</pre>
  * Show the PID for the active server
    <pre>$ make pid</pre>
  * Show any service on the port specified in config.ini
    <pre>$ make port</pre>
  * Open the default browser with python, to your server
    <pre>$ make browse</pre>

# Testing

  * Run full test suite
    <pre>$ make test</pre>

# TODO List

  * Make configuration editor inside of 'make config'
  * Make configuration editor inside of 'make testconfig'
  * Add testing for each individual method, so that they can be run independent of 'make test'

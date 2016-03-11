# Introduction

  * Just a little test project, to serve HTML or Markdown using node type web servers or simply using python SimpleHTTPServer

## Requirements

### Using http-server

  * npm
  * npm packages:
    * http-server
  * make

### Using harp

  * npm
  * npm packages:
    * harp
  * make

### Using python SimpleHTTPServer

  * make
  * python (version >= 2.7)

## Installation

### Using http-server

  * <pre>$ npm install</pre>

### Using harp

  * <pre>$ npm install</pre>

### Using python SimpleHTTPServer

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

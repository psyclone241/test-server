# Introduction
Just a little test project, implementing the node project, http-server

# Requirements
* npm
* npm packages:
  * http-server
* make

# Installation
<pre>npm install</pre>

# Configuration
* Copy config.ini.example to config.ini
<pre>cp config.ini.example config.ini</pre>
* Edit your new config.ini file for your preferences

# Usage
* Show your options
<pre>make</pre>
* Configure your server or create a new config
<pre>make config</pre>
* Configure your test suite or create a new test config
<pre>make testconfig</pre>
* Run your server
<pre>make start</pre>
* Stop your server
<pre>make stop</pre>
* Restart your server
<pre>make restart</pre>
* Show the PID for the active server
<pre>make pid</pre>
* Show any service on the port specified in config.ini
<pre>make port</pre>

# Testing
* Run full test suite
<pre>make test</pre>

# TODO List
* Make configuration editor inside of 'make config'
* Make configuration editor inside of 'make testconfig'
* Add testing for each individual method, so that they can be run
independent of 'make test'

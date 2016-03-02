# Introduction
Just a little setup to run a node server on any small project

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

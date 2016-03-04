# Helper script for setting up your apps local instance
# Contributors:
# Roy Keyes <keyes@ufl.edu>

help:
	@echo "Available tasks :"
	@echo "\tconfig - make or update a configuration file"
	@echo "\tstart - start the http-server instance, export the logs, and background the process"
	@echo "\tstop - find and kill the http-server instance"
	@echo "\trestart - find and kill the http-server instance, then start a new one"
	@echo "\tport - find any services running on the configured por"
	@echo "\tpid - find the PID of any http-server instance running"
	@echo "\ttest - run the testing suites"

config:
	@bash scripts/run.sh config

start:
	@bash scripts/start.sh

stop:
	@bash scripts/stop.sh

restart:
	@bash scripts/restart.sh

port:
	@bash scripts/run.sh port

pid:
	@bash scripts/run.sh pid

test:
	@bash tests/run.sh

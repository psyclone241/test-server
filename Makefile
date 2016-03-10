# Helper script for setting up your apps local instance
# Contributors:
# Roy Keyes <keyes@ufl.edu>

help:
	@echo "Available tasks :"
	@echo "\tconfig - make or update a configuration file"
	@echo "\ttestconfig - make or update a test configuration file"
	@echo "\tstart - start the service instance, export the logs, and background the process"
	@echo "\tstop - find and kill the service instance"
	@echo "\trestart - find and kill the service instance, then start a new one"
	@echo "\tport - find any services running on the configured por"
	@echo "\tpid - find the PID of any service instance running"
	@echo "\ttest - run the testing suites"

config:
	@bash scripts/run.sh config

testconfig:
	@bash scripts/run.sh testconfig

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

browse:
		@bash scripts/run.sh browse

test:
	@bash tests/run.sh

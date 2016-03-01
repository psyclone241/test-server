# Helper script for setting up your apps local instance
# Contributors:
# Roy Keyes <keyes@ufl.edu>

help:
	@echo "Available tasks :"
	@echo "\tstart - start the http-server instance, export the logs, and background the process"
	@echo "\tstop - find and kill the http-server instance"
	@echo "\trestart - find and kill the http-server instance, then start a new one"

start:
	@source scripts/config.ini
	@bash scripts/start.sh

stop:
	@source scripts/config.ini
	@bash scripts/stop.sh

restart:
	@source scripts/config.ini
	@bash scripts/restart.sh

check:
	@source scripts/config.ini
	@bash scripts/check.sh $PORT

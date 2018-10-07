#!/bin/bash

# Upgrader -- Debian/Ubuntu Update Tool (Version 1.0)
# Created by Sankul Rawat [www.sankulrawat.com] (MIT License)

# Exit on error
set -e

# Functions

update() {
	echo "Starting full system update..."
	sudo apt-get update
	sudo apt-get full-upgrade -yy
}

clean() {
	echo "Cleaning up..."
	sudo apt-get autoremove -yy
	sudo apt-get autoclean
}

leave()
{
	echo "----------------------"
	echo "-  Update Complete!  -"
	echo "----------------------"
	exit
}

upgrader-help() {

cat << _EOF_

Usage: upgrader [Options]

Upgrader is a tool that automates the update procedure for debian based systems.

Options:
	<No option>	Running with no options does full system update.
	--clean		Full system update with cleanup.
	--help		Shows this help page.

_EOF_
}

# Execution
echo "Upgrader -- Debian/Ubuntu Update Tool (Version 1.0)"

# Update and Clean
if [ "$1" == "--clean" ]; then
	update
	clean
	leave
fi

# Help
if [ "$1" == "--help" ]; then
	upgrader-help
	exit
fi

# Check for invalid arguments
if [ -n "$1" ]; then
	echo "Upgrader Error: Invalid argument. Try 'upgrader --help' for more info." >&2
	exit 1
fi

# Without arguments
update
leave
	

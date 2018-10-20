#!/bin/bash

create_deb_package(){
	command_output=$(apt-cache policy $1 | grep Installed &> /dev/null)
	
	echo "$command_output"	
	if [[ "$command_output" == *"Installed"* ]]; then
		echo "Installed"
	fi
	echo "hello"
}

create_deb_package "$1"

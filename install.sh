#!/bin/bash 

set -e

$PACKAGE_ID

startup() {
	echo "---Welcome to Utility Scripts Tools (Version 0.0.1)---"
	echo "What kind of package would you like to install? (insert the id)..."
	echo "ID	-	Package Name"
	echo "1		-	Install all scripts"
	echo "2 	- 	Exit"

	read -p "Your choice (package ID): " PACKAGE_ID
}

install() {
	echo "Initiating install..."
	echo "Checking existence of $HOME/bin directory..."

	if [ "$PACKAGE_ID" -eq "1" ]; then
		if [ -d "$HOME/bin" ]; then
			echo "$HOME/bin directory found."
			echo "Copying scripts to $HOME/bin..."
			cp *.sh "$HOME/bin"
			rm "$HOME/bin/install.sh"
			echo "Scripts successfully copied."
		else
			echo "$HOME/bin directory not found."
			echo "Creating the $HOME/bin directory..."
			mkdir "$HOME/bin"
			echo "Directory successfully created."
			echo "Copying scripts now..."
			cp *.sh "$HOME/bin"
			rm "$HOME/bin/install.sh"
			echo "Scripts successfully copied."
		fi
	fi

	echo "Installation completed without errors."
}


startup

if [ "$PACKAGE_ID" -gt "0" ] && [ "$PACKAGE_ID" -lt "3" ]; then 
	install
else
	echo "Incorrect choice. Please choose a valid ID."
	startup
fi



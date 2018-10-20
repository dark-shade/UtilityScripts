#!/bin/bash

set -e

create_deb_package(){
	echo "Equivs package is a dependency."
	echo "Checking Equivs existence."
	
	command_output=$(apt-cache policy equivs | grep Installed)
	
	if [[ "$command_output" == *"Installed"* ]]; then
		echo "Equivs is installed."
		
	else
		echo "Equivs not installed. Installing it now..."
		apt-get install quivs
		echo "Equivs installed."
	fi

	echo "Creating debian package..."
	mkdir -p "$HOME/webupdpackage/debian"
	equivs-control "$HOME/webupdpackage/debian/control"
	pkgs=$(aptitude search -F %p ~i --disable-columns libedataserver | sed 's/$/,/' | tr '\n\r' ' ' | sed 's/, $//')
	echo '### Commented entries have reasonable defaults.
	### Uncomment to edit them.
	Section: misc
	Priority: optional
	Standards-Version: 3.6.2

	Package: webupd8package
	Version: 1.0
	Maintainer: Andrew < andrew@webupd8.org >
	# Pre-Depends: <comma-separated list of packages>
	Depends: '$pkgs'
	# Recommends: <comma-separated list of packages>
	# Suggests: <comma-separated list of packages>
	# Provides: <comma-separated list of packages>
	# Replaces: <comma-separated list of packages>
	Architecture: all
	# Copyright: <copyright file; defaults to GPL2>
	# Changelog: <changelog file; defaults to a generic changelog>
	# Readme: <README.Debian file; defaults to a generic one>
	# Extra-Files: <comma-separated list of additional files for the doc directory>
	Description: All my applications packed into a deb file' > "$HOME/webupdpackage/debian/control"
	equivs-build "$HOME/webupdpackage/debian/control"
	cp *.deb .
	rm -rf "$HOME/webupdpackage"
	echo "Debian package constructed successfully. Please find it in your current directory."
}

create_deb_package

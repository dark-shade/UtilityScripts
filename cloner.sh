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
	printf "### Commented entries have reasonable defaults.\n### Uncomment to edit them.\nSection: misc\nPriority: optional\nStandards-Version: 3.6.2\n\nPackage: webupd8package\nVersion: 1.0\nMaintainer: Andrew < andrew@webupd8.org >\n# Pre-Depends: <comma-separated list of packages>\nDepends: %s\n# Recommends: <comma-separated list of packages>\n# Suggests: <comma-separated list of packages>\n# Provides: <comma-separated list of packages>\n# Replaces: <comma-separated list of packages>\nArchitecture: all\n# Copyright: <copyright file; defaults to GPL2>\n# Changelog: <changelog file; defaults to a generic changelog>\n# Readme: <README.Debian file; defaults to a generic one>\n# Extra-Files: <comma-separated list of additional files for the doc directory>\nDescription: All my applications packed into a deb file" "$pkgs" > "$HOME/webupdpackage/debian/control"
	equivs-build "$HOME/webupdpackage/debian/control"
	cp *.deb .
	rm -rf "$HOME/webupdpackage"
	echo "Debian package constructed successfully. Please find it in your current directory."
}

create_deb_package

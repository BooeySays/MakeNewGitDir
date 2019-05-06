#!/bin/bash

function __get_git_username(){
	echo -en """
	Please enter the GitHub username you want to
	associate with this script : """
	read -r GITUSERNAME
	echo """#!/bin/bash\n\nexport GIT_USER=$GITUSERNAME""" > "$BOOEYSRC/mkgit.sh"
	unset GITUSERNAME
}
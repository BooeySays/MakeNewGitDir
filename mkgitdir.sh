#!/bin/bash

## [ TODO: ] ##################################
#
# 1.	Add a function to get github username
# 		and switch out:
#
#		"https://github.com/DX2DigitalGroup"
#
#		...with the new url with the user's
#		username inserted instead.
#
###############################################

function __make_git_dir(){
GITDIRNAME=$1
## If the directory name doesnt exist...
	if [ ! -d ./"$GITDIRNAME" ]; then
## Make a dir with the name
		mkdir -p "$GITDIRNAME"
		cd "$GITDIRNAME"
	else
## Othetwise, spit out an error msg.
		echo -e """
\033[38;5;226m ERROR \033[m
	There already is a directory/file the current location that
	is named \""$GITDIRNAME"\".

	Please try again with another directory name.

	"""
## and then exit the script
		return 0
	fi
}

function __git_create_readme(){
	GITDIRNAME=$1
##
##	create the README.md file
	echo -e "# $GITDIRNAME" > README.md
##
## git init
}

function __git_create_repo(){
	GITDIRNAME=$1
	git init
##
## create a backup of the config file in ./.git
	cp ./.git/config ./.git/config.bak
##
## Add a few new lines to the config
## file in the .git dir
	echo -e """[remote \"origin\"]
    url = https://github.com/DX2DigitalGroup/"$GITDIRNAME".git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch \"master\"]
    remote = origin
    merge = refs/heads/master""" >> ./.git/config
## hub create
	hub create
##
## git add files
	git add --all
##
## Get commit message to use for git commit command
	echo
	read -p 'Please enter commit message to use: ' -r GITCOMMIT_MSG
	git commit -m '"$GITCOMMIT_MSG"'
	unset GITCOMMIT_MSG
	git push -u origin master
}

## function to check if hub is installed

function __chk_for_hub(){
	if hash hub 2>/dev/null; then
		hub create
	else
		echo -en """

\033[38;5;229m ALERT ! \033[m

\033[38;5;15m\tHub is not installed on this system.

Would you like to install it now ?

[Y]es | [N]o"""
		read -p ': ' -n 1 -r installhubYN
		case $installhubYN in
		Y|y)
			__installhub
			;;
		n|N)
			return 0
			;;
		*)
			echo "Invalid selection"
			return 0
			;;
		esac
	fi
}

function __installhub(){
	if hash pkg 2>/dev/null/; then
		pkg update -y && pkg install hub -y
	else
		apt update -y && apt install hub -y
	fi
}

function mkgit(){
	if [ $1 ]; then
		GITDIR_P=$1
	else
		echo -en "\033c\n\tPlease enter the name you want to use\n\tfor this new repo: "
		read -r GITDIR_P
	fi

	__make_git_dir "$GITDIR_P"
	__git_create_readme "$GITDIR_P"
	__git_create_repo "$GITDIR_P"
	__chk_for_hub
}

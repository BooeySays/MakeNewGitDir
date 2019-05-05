#!/bin/bash

GITDIR=$1
## If the directory name doesnt exist...
if [ ! -d ./"$GITDIR" ]; then
## Make a dir with the name
	mkdir -p "$GITDIR"
else
## Othetwise, spit out an error msg.
	echo -e """
\033[38;5;226m ERROR \033[m
	There already is a directory/file the current location that
	is named \""$GITDIRITDIR"\".

	Please try again with another directory name.

	"""
## and then exit the script
	return 0
fi
cd "$GITDIR"							## cd into the new dir
##
##	create the README.md file
echo -e '# "$GITDIR"' > README.md
##
## git init
git init
##
## create a backup of the config file in ./.git
cp ./.git/config ./.git/config.bak
##
## Add a few new lines to the config
## file in the .git dir
echo -e """[remote \"origin\"]
    url = https://github.com/DX2DigitalGroup/"$GITDIR".git
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
echo -en """Please enter commit message to use: """
read -r GITCOMMIT_MSG
git commit -m '"$GITCOMMIT_MSG"'
unset GITCOMMIT_MSG
git push -u origin master

## function to check if hub is installed

function __chk_for_hub(){
	if hash hub 2>/dev/null/; then
		hub create
	else
		echo -en """

\033[38;5;229m ALERT ! \033[m

\033[38;5;15m\tHub is not installed on this system.

Would you like to install it now ?

[Y]es | [N]o:"""
read -p ': ' -n 1 -r installhubYN
case $installhubYN in
	Y|y
		__installhub
		;;
	n|N)
		return 0
		;;
	*)
		echo "Invalid selection"
		;;
esac
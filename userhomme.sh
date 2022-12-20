#!/bin/bash

file=""
login=""

if [[ "$1" = "-f" ]]
then
	file="$2"
	login="$3"
else
	login="$1"
fi

if [[ "$login" = "" ]]
then
	login=$(whoami)
fi

if [[ "$file" = "" ]]
then
	s=$(grep "^${login}:" /etc/passwd)
else 
	if [[ ! -e $file ]]
	then
		echo "File did not found." >&2
		exit 2
	fi
	s=$(grep "^${login}:" "$file")
fi

if [[ "$s" = "" ]]
then
	echo "User not found."
	exit 1
fi

s=${s%:*}
s=${s##*:}

if [[ "$s" != "" ]]
then
	echo "$s"
	exit 0
fi

	

#!/bin/bash

if [[ "$#" -ne "3" ]]; then
	>&2 echo "Incorrect argc"
	exit 1
fi

#setup aliases
shopt -s expand_aliases
. ~/.pub_aliases

#setup variables
FILE_PATH=$(readlink -f "$1")
REPO_OWNER="$2"
REPO_NAME="$3"

UUID=$(jq -r ".uuid" <"$FILE_PATH")

cd repositories/"$REPO_OWNER"
cp "$FILE_PATH" "$REPO_NAME"

#generate symlink
cd ../by-uuid
rm "$UUID"
ln -s ../"$REPO_OWNER"/"$REPO_NAME" "$UUID"

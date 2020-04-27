#!/bin/bash

if [[ "$#" -ne "1" ]]; then
	>&2 echo "Incorrect argc"
	exit 1
fi

#setup variables
TYPE="$1"

IFS="." read -ra VERSION_PARTS <.partial_version
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
PATCH="${VERSION_PARTS[2]}"

if [[ "$TYPE" == "major" ]]; then
	((++MAJOR))
	MINOR=0
	PATCH=0
elif [[ "$TYPE" == "minor" ]]; then
	((++MINOR))
	PATCH=0
elif [[ "$TYPE" == "patch" ]]; then
	((++PATCH))
else
	>&2 echo "Invalid version type"
	exit 1
fi

echo "$MAJOR.$MINOR.$PATCH" >.partial_version

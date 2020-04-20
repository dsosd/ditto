#!/bin/bash

if [[ "$#" -ne "2" ]]; then
	>&2 echo "Incorrect argc"
	exit 1
fi

#setup aliases
shopt -s expand_aliases
. ~/.pub_aliases

#setup variables
REPO_OWNER="$1"
REPO_NAME="$2"
UUID=$(gen_uuid)

DEST=".repo_id"

#generate json data
jq -n --arg name "$REPO_NAME" --arg owner "$REPO_OWNER" --arg uuid "$UUID" '{"uuid":$uuid, "owner":$owner, "canonical_name":$name}' >"$DEST".temp

#move only if file will not be overwritten
mv -n "$DEST".temp "$DEST"

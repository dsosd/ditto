#!/bin/bash

if [[ "$#" -ne "3" ]]; then
	>&2 echo "Incorrect argc"
	exit 1
fi

#setup variables
BASE_PATH="$1"
REPO_OWNER="$2"
REPO_NAME="$3"

if [[ ! -f "repositories/$REPO_OWNER/$REPO_NAME" ]]; then
	>&2 echo "Repo id file does not exist"
	exit 2
fi

PULL_URL=$(cat "repositories/$REPO_OWNER/$REPO_NAME" | jq 'if (.bootstrap_pull_url | length) != 0 then .bootstrap_pull_url else empty end')

if [[ -z "$PULL_URL" ]]; then
	>&2 echo "No pull url in repo id file"
	exit 3
fi

#trim off quotes from json
PULL_URL="${PULL_URL:1:-1}"

mkdir -p "$BASE_PATH/$REPO_OWNER"
git clone "$PULL_URL" "$BASE_PATH/$REPO_OWNER/$REPO_NAME"

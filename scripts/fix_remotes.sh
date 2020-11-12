#!/bin/bash

FILES=("L0_srcs" "L1_srcs")
for file in "${FILES[@]}"; do
	echo "> $file:"
	mapfile -t GIT_REMOTES < <(jq -r "keys[]" "$file")

	for remote in "${GIT_REMOTES[@]}"; do
		REMOTE_EXISTS=$(git remote show -n | grep "$remote" | wc -l)
		URL=$(jq -r ".[\"$remote\"]" "$file")

		if [[ "$REMOTE_EXISTS" == "0" ]]; then
			echo "Add $remote"
			git remote add "$remote" "$URL"
		else
			echo "Fix $remote"
			git remote set-url "$remote" "$URL"
		fi
	done
done

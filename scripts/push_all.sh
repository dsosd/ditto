#!/bin/bash

mapfile -t GIT_REMOTES < <(jq -r "keys[]" L0_srcs)

for remote in "${GIT_REMOTES[@]}"; do
	git push $remote master
done

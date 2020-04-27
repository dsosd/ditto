#!/bin/bash

mapfile -t GIT_REMOTES_0 < <(jq -r "keys[]" L0_srcs)
mapfile -t GIT_REMOTES_1 < <(jq -r "keys[]" L1_srcs)

for remote in "${GIT_REMOTES_0[@]}"; do
	git push $remote master "$@"
done

for remote in "${GIT_REMOTES_1[@]}"; do
	git push $remote master "$@"
done

#!/usr/bin/env bash
set -euo pipefail

# read a single variable from the configuration
VAR=$(echo "$1" | yq -I=0 ".var") # `-I=0` makes sure the output isn't indented
echo "$VAR"

# read an array from the configuration
get_yaml_array ARRAY '.array[]' "$1"
# loop over the array
for THING in "${ARRAY[@]}"; do
	echo "$THING"
done

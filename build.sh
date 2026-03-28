#!/bin/bash
set -euo pipefail

read -r BRANCH < branch.txt

echo "Building branch $BRANCH"

if [ ! -d "openwrt" ]; then
	echo "openwrt has not been cloned!"
	exit 1
fi

cd openwrt

make -j$(nproc) clean world

EXIT_CODE=$?

cd -

echo "Done building with exit code: $EXIT_CODE"

#!/bin/bash
set -euo pipefail

echo "Cleaning builder..."

read -r BRANCH < branch.txt

echo "Loaded branch $BRANCH"

if [ -d "openwrt" ]; then
        echo "OpenWRT already cloned! Resetting and cleaning!"
        cd openwrt
        pwd
        git reset --hard
        git clean -xfd
        cd -
else
        git clone --branch $BRANCH https://github.com/ronhombre/openwrt.git
fi

echo "Builder cleaned!"

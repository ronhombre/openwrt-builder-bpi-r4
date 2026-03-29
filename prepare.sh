#!/bin/bash
set -euo pipefail

echo "Preparing builder..."

read -r BRANCH < branch.txt

echo "Loaded branch $BRANCH"

if [ ! -d "openwrt" ]; then
	git clone --branch $BRANCH https://github.com/ronhombre/openwrt.git
fi

cp config openwrt/.config

cd openwrt

./scripts/feeds update -a
./scripts/feeds install -a

make -j$(nproc) defconfig download

cd -

echo "Builder prepared!"

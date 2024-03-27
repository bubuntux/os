#!/usr/bin/env bash

set -oue pipefail

cd /tmp

# Install ipu6-camera-bins
git clone git@github.com:intel/ipu6-camera-bins.git
cp -r ipu6-camera-bins/include/* /usr/include/
cp -r ipu6-camera-bins/lib/* /usr/lib/
rm -rf ipu6-camera-bins

# Install ivsc-firmware
git clone git@github.com:intel/ivsc-firmware.git
mkdir -p /lib/firmware/vsc
cp -r ivsc-firmware/firmware/* /lib/firmware/vsc
rm -rf ivsc-firmware
mkdir -p /lib/firmware/vsc/soc_a1_prod/
for file in /lib/firmware/vsc/*.bin; do
	ln -sf "$file" "/lib/firmware/vsc/soc_a1_prod/$(basename "$file" .bin)_a1_prod.bin"
done

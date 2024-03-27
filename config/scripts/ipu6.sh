#!/usr/bin/env bash

set -oue pipefail

rpm-ostree install akmod-intel-ipu6

exit 0

cd /tmp

# Install ipu6-camera-bins
curl https://codeload.github.com/intel/ipu6-camera-bins/zip/refs/heads/main -o ipu6-camera-bins.zip
unzip ipu6-camera-bins.zip
cp -r ipu6-camera-bins-main/include/* /usr/include/
cp -r ipu6-camera-bins-main/lib/* /usr/lib/
rm -rf ipu6-camera-bins*

# Install ivsc-firmware
curl https://codeload.github.com/intel/ivsc-firmware/zip/refs/heads/main -o ivsc-firmware.zip
unzip ivsc-firmware.zip
mkdir -p /lib/firmware/vsc
cp -r ivsc-firmware-main/firmware/* /lib/firmware/vsc
rm -rf ivsc-firmware*
mkdir -p /lib/firmware/vsc/soc_a1_prod/
for file in /lib/firmware/vsc/*.bin; do
	ln -sf "$file" "/lib/firmware/vsc/soc_a1_prod/$(basename "$file" .bin)_a1_prod.bin"
done

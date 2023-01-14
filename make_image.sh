#!/bin/bash
function copy_file(){
	path=$1
	mkdir ~/firmware
	mkdir ~/packages
	cd $path
	rm -rf packages
	cp -rf ./* ~/firmware
}
if [[ "$DEBUG" == "1" ]]; then
  set
  cat .config
  ls -la files
fi
cp -r custom/* packages/
cp -r hiui/* packages/
sed \
  -e '/^CONFIG_TARGET_ROOTFS_EXT4FS/ s/^#*/#/' \
  -i .config
  
make image \
  PROFILE="$PROFILE" \
  FILES="$FILES" \
  PACKAGES="$PACKAGES" \
  DISABLED_SERVICES="$DISABLED_SERVICES" \
  EXTRA_IMAGE_NAME="$EXTRA_IMAGE_NAME"

copy_file ~/openwrt/bin/targets/*/*
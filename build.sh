#!/bin/bash

cd /mango414
echo "cloning toolchain..."
git clone https://github.com/mscalindt/aarch64-linux-android-4.9.git --depth=1
CROSS_COMPILE+="aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export CROSS_COMPILE
export ARCH=arm64
export SUBARCH=arm64
make clean
make mango_defconfig
make -j8
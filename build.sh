#!/bin/bash

echo "cloning toolchain..."
git clone https://github.com/mscalindt/aarch64-linux-android-4.9.git --depth=1 gcc 
git clone https://github.com/JamieHoSzeYui/android_prebuilts_clang_host_linux-x86_clang-6443078 --depth=1
CROSS_COMPILE+="aarch64-linux-android-4.9/bin/aarch64-linux-android-" clang 
make O=out ARCH=arm64 mango_defconfig

PATH="clang/bin:gcc/bin:gcc/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-


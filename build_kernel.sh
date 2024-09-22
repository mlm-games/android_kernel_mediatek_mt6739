#!/bin/bash

set -e

# Check if defconfig is provided
if [ -z "$1" ]; then
    echo "Error: Please enter the defconfig"
    exit 1
fi

# Set up toolchain
TOOLCHAIN_DIR="../arm-linux-androideabi-4.9"
if [ ! -d "$TOOLCHAIN_DIR" ]; then
    echo "GCC toolchain not available at $TOOLCHAIN_DIR"
    exit 1
fi

# Clean up previous builds
rm -rf out
mkdir out

# Clean the kernel source
make clean
make mrproper

# Set up environment variables
export CROSS_COMPILE="$(pwd)/$TOOLCHAIN_DIR/bin/arm-linux-androideabi-"
export ARCH=arm
export O=out

# Build the kernel
make $1 O=out
make -j$(nproc) O=out

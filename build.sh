#!/bin/bash
#
#
#

. env.sh

GENERATED_DIRS="kernels images"

if [ "$1" == "clean" ]; then
    echo "Cleaning workspace... "
    for DIR in $GENERATED_DIRS; do
        rm -rf $DIR
    done
    exit 0
fi

for DIR in $GENERATED_DIRS; do
    mkdir -p $DIR
done

#
# Download kernels
#
cd kernels
if [ ! -d "qemu-rpi-kernel" ]; then
    git clone https://github.com/dhruvvyas90/qemu-rpi-kernel.git
fi
cd ..

#
# Download image(s)
#
cd images
    wget -N $IMAGE_URL
cd ..


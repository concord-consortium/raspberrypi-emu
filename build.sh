#!/bin/bash
#
#
#

. env.sh

GENERATED_DIRS="kernels images"

if [ "$1" == "clean" ]; then
    echo "Cleaning workspace..."
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
echo "Downloading kernels..."
cd kernels
if [ ! -d "qemu-rpi-kernel" ]; then
    git clone https://github.com/dhruvvyas90/qemu-rpi-kernel.git
fi
cd ..

#
# Download and unzip image
#
echo "Downloading image $IMAGE..."
cd images
wget -N $IMAGE_URL
if [ ! -f "$IMAGE" ]; then
    echo "Unzipping image $IMAGE..."
    unzip -o $IMAGE_ZIP
fi
cd ..

#
# Mount image and modify for qemu
#
echo "Configuring image $IMAGE..."
sudo mkdir -p /mnt/rpi
sudo kpartx -av images/$IMAGE
sleep 5
sudo mount /dev/mapper/loop0p2 /mnt/rpi

sudo umount /mnt/rpi
sudo kpartx -d images/$IMAGE
sudo rmdir /mnt/rpi



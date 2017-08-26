#!/bin/bash
#
#
#

. env.sh

GENERATED_DIRS="kernels images tmp"

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
# Mount image, modify image for qemu, unmount
#
echo "Configuring image $IMAGE..."

echo "Mounting..."
sudo mkdir -p /mnt/rpi
sudo kpartx -av images/$IMAGE
sleep 2
sudo mount /dev/mapper/loop0p2 /mnt/rpi

echo "Configuring..."

cp /mnt/rpi/etc/fstab tmp
sed -e '/^\/dev\/mmcblk0p.*/s/^/# /g' -i tmp/fstab
sudo cp tmp/fstab /mnt/rpi/etc/fstab

cp /mnt/rpi/etc/ld.so.preload tmp
sed -e '/^\/usr.*/s/^/# /g' -i tmp/ld.so.preload
sudo cp tmp/ld.so.preload /mnt/rpi/etc/ld.so.preload

echo "Unmounting..."
sudo umount /mnt/rpi
sudo kpartx -d images/$IMAGE
sudo rmdir /mnt/rpi



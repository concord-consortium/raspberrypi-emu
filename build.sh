#!/bin/bash
#
#
#

. env.sh

GENERATED_DIRS="kernels images runtime tmp"
OS=`uname`

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

if [ "$1" == "--kernels-only" ]; then
    echo
    echo "Kernels downloaded."
    echo
    exit 0
fi

#
# Download and unzip image
#
echo "Downloading image $IMAGE..."
cd images
wget -N $IMAGE_URL
if [ ! -f "$QEMU_IMAGE" ]; then
    echo "Unzipping image $IMAGE..."
    unzip -o $IMAGE_ZIP
    cp $IMAGE $QEMU_IMAGE
fi
cd ..

#
# Mount image, modify image for qemu, unmount
#
echo "Configuring image $QEMU_IMAGE..."

mkdir -p tmp
rm -rf tmp/*

if [ "$OS" == "Darwin" ]; then

    #
    #
    # Need to install osxfuse with MacFuse Compatibility Layer
    # See https://github.com/osxfuse/osxfuse/wiki/FAQ
    #
    # Need to install fuse-ext2
    # See https://github.com/alperakcan/fuse-ext2
    # Follow script in README.md - this is a pain.
    # The build also complains even though it succeeds. Hmm..
    # 

    which fuse-ext2

    if [ "$?" != "0" ]; then
        echo "ERROR fuse-ext2 not installed."
        echo "Install fuse-ext2 to mount the ext4 image in rw+ mode."
        exit 1
    fi
    
    echo "Mounting..."
    DEV=`hdiutil mount images/$QEMU_IMAGE | grep Linux | awk '{print $1}'`
    mkdir -p mnt 
    fuse-ext2 $DEV mnt -o rw+

    echo "Configuring..."

    cat mnt/etc/fstab | sed -e '/^\/dev\/mmcblk0p.*/s/^/# /g' > tmp/fstab
    sudo cp tmp/fstab mnt/etc/fstab
    
    cat mnt/etc/ld.so.preload | sed -e '/^\/usr.*/s/^/# /g' > tmp/ld.so.preload
    sudo cp tmp/ld.so.preload mnt/etc/ld.so.preload
 
    echo "Unmounting..."
    umount mnt
    hdiutil eject $DEV
    rmdir mnt

else

    echo "Mounting..."
    sudo mkdir -p mnt
    DEV=`sudo kpartx -av images/$QEMU_IMAGE | grep "add map loop[0-9]p2" | cut -d ' ' -f 3`

    sleep 2
    sudo mount /dev/mapper/$DEV mnt
    
    echo "Configuring..."
    
    cp mnt/etc/fstab tmp
    sed -e '/^\/dev\/mmcblk0p.*/s/^/# /g' -i tmp/fstab
    sudo cp tmp/fstab mnt/etc/fstab
    
    cp mnt/etc/ld.so.preload tmp
    sed -e '/^\/usr.*/s/^/# /g' -i tmp/ld.so.preload
    sudo cp tmp/ld.so.preload mnt/etc/ld.so.preload
    
    echo "Unmounting..."
    sudo umount mnt
    sudo kpartx -d images/$QEMU_IMAGE
    sudo rmdir mnt

fi


#
# Copy built image to runtime location
#
cp images/$QEMU_IMAGE runtime/$QEMU_IMAGE


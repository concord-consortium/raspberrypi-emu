#!/bin/bash
#
# Start Raspberry Pi
#
#

. env.sh

qemu-system-arm -kernel $KERNEL_DIR/$KERNEL \
                -cpu arm1176 \
                -m 256 \
                -M versatilepb \
                -no-reboot -serial stdio \
                -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
                -redir tcp:5022::22 \
                -hda $IMAGE_DIR/$IMAGE


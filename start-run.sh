#!/bin/bash
#
# Start the Raspberry Pi in fully functional mode!
#

. env.sh

qemu-system-arm -kernel $KERNEL -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda $IMAGE

#!/bin/bash
#
# Starts raspberry pi image in configuration mode
#
# Based on 
# http://embedonix.com/articles/linux/emulating-raspberry-pi-on-linux/
#
# See also https://stackoverflow.com/questions/38837606/emulate-raspberry-pi-raspbian-with-qemu
#

. env.sh

qemu-system-arm -kernel $KERNEL -cpu arm1176 -m 256 -M versatilepb -no-reboot -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw init=/bin/bash" -hda $IMAGE



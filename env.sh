#!/bin/bash
#
# Obtain KERNEL kernel names from:
# https://github.com/dhruvvyas90/qemu-rpi-kernel.git
#
# Obtain IMAGE_URL image URLs from:
# http://downloads.raspberrypi.org/raspbian/images/
# 
# Ensure you specify a work kernel and image pair.
# 


#
# Working Wheezy kernel+image pair
#
# KERNEL=kernel-qemu-3.10.25-wheezy
# IMAGE_URL=http://downloads.raspberrypi.org/raspbian/images/raspbian-2015-02-17/2015-02-16-raspbian-wheezy.zip


#
# Working Jessie kernel+image pair
#
KERNEL=kernel-qemu-4.4.12-jessie
IMAGE_URL=http://downloads.raspberrypi.org/raspbian/images/raspbian-2016-05-31/2016-05-27-raspbian-jessie.zip


#
# Set IMAGE_ vars based on IMAGE_URL
#
IMAGE_ZIP=`echo $IMAGE_URL | sed 's/.*\///'`
IMAGE=`echo $IMAGE_ZIP | sed 's/\.zip$/.img/'`

#
# 
#
KERNEL_DIR=kernels/qemu-rpi-kernel
IMAGE_DIR=images/



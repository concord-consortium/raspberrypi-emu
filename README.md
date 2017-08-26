# raspberrypi-emu


Creates Raspberry Pi images that run under Qemu.

- Downloads qemu raspberry pi kernels
- Downloads raspberry pi images
- Creates runnable qemu images


## Install and Run

Clone this repo.

`git clone https://github.com/concord-consortium/raspberrypi-emu`

Enter repo dir.

`cd raspberrypi-emu`

Run build.sh using sudo. (Requires the use of sudo for root privileges to mount images.)

`sudo ./build.sh`

Run start-pi.sh to start the emulator.

`./start-pi.sh`


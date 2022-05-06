#!/bin/sh
make -C /lib/modules/`uname -r`/build M=/usr/src/linux-5.16.13/drivers/hid hid-logitech-hidpp.ko

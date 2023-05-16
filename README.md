# Logitech MX Master 3 mouse in Linux
This is a kbuild for a fixed Linux hid-logitech-hidpp driver, which is used by the Logitech MX Master 3 wireless mouse (among others).  It's built as an out-of-tree module.

## The problem that's been addressed
When using the stock kernel driver, as provided by Logitech, the mouse wheel of the Logitech MX Master 3 ignores the first input whenever the mouse wheel changes its direction, i.e. if you're scrolling down and then try to scroll up, the Logitech driver does nothing for the first upward "click" of the wheel.  This makes the mouse feel clunky and unresponsive.  I found this incredibly irritating, so I modified the driver source code and threw together a build script so I could replace my kernel module.

To read more about this issue and why it was implemented as a work around, I've quoted the applicable portion of the kernel submission notes below.  From [https://lwn.net/Articles/772785/](https://lwn.net/Articles/772785/):

```
Notable: The Logitech REL_WHEEL emulation cannot just hook into the HID
bits. The firmware drops some events so the point when we get the REL_WHEEL
event moves around. This is worked around by directional resets and a
timeout-based reset.
```

I've noticed no problems with my implementation, but YMMV.


## Compiling
Clone this repository and build the module:
```
git clone https://github.com/mtmiron/hid-logitech-hidpp
cd hid-logitech-hidpp
make
```

The help and clean targets are also available:
```
make help
> make -C /lib/modules/`uname -r`/build M=$PWD help
> make[1]: Entering directory '/usr/lib/modules/5.17.5-arch1-1/build'
>   Building external modules.
>   Syntax: make -C path/to/kernel/src M=$PWD target
>
>   modules         - default target, build the module(s)
>   modules_install - install the module
>   clean           - remove generated files in module directory only
>
> make[1]: Leaving directory '/usr/lib/modules/5.17.5-arch1-1/build'
```


For further information, see [https://www.kernel.org/doc/Documentation/kbuild/modules.txt](https://www.kernel.org/doc/Documentation/kbuild/modules.txt "kbuild documentation")

## Installing
Personally I just deleted the stock "hid-logitech-hidpp.ko.zst" file from my Linux kernel module directory, and now it automatically loads my version instead after running "make modules_install" using the Makefile provided herein.  The modified driver goes into the "extras" directory along with any other out-of-tree modules.  Please note that I am not committing to maintaining this driver in the future, but I do intend to keep it working for as long as I happen to use this mouse with my day-to-day setup.

## Errata
Note that your Linux kernel must have been built with loadable module support compiled in, and that the hid-logitech-hidpp driver must have been configured as a loadable module and not a compiled-in driver (the vast majority of Linux distributions make almost everything a module in order to support the widest range of hardware possible).  Note also that just deleting the module file and installing a new one will not change the running kernel.  If you want to use the new driver without a reboot, after deleting the old one and installing the new one (`make modules_install` will require root privileges, of course), at a command prompt run this:

```
sudo rmmod hid-logitech-hidpp && sudo modprobe hid-logitech-hidpp
```

Leave out `sudo` if you're logged in as root or otherwise don't need superuser permissions (but you almost certainly will).  That will unload the running module, and then load the modified version.  No reboot necessary.

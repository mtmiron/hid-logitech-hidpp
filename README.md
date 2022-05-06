# Logitech MX Master 3 mouse in Arch Linux
This is a quick-and-dirty setup to build the hid-logitech-hidpp driver, which is used by the Logitech MX Master 3 wireless mouse.  It's built as an out-of-tree module.

## Why? (aka "The problem")
When using the stock kernel driver, as provided by Logitech, the mouse wheel of the Logitech MX Master 3 ignores the first input whenever the mouse wheel changes its direction, i.e. if you're scrolling down and then try to scroll up, the Logitech driver does nothing for the first upward "click" of the wheel.  This makes the mouse feel clunky and unresponsive.  I found this incredibly irritating, so I modified the driver source code and threw together a build script so I could replace my kernel module.

## Problems you may (and/or will) run into trying to use this blindly
The modified driver is, in my opinion, rock solid (or so several weeks of use would have me believe).[^1]  The trivially simple build script, however, does not work with any kernel source code except v5.16.13; i.e., you need to download that specific version of the kernel source from [https://www.kernel.org](https://www.kernel.org "Kernel.org") and decompress it to `/usr/src/linux-5.16.13`, or change the directory to whatever version you'd like in `build.sh` -- any version that includes the same hid-logitech-hidpp driver code will work.  As of May 2nd, 2022, the current stable kernel (v5.17.5) includes no changes to said driver since v5.16.13.

Note that `build.sh` does not replace the kernel driver file, it just builds one.  To change which module file is loaded, you'll want to compress the `hid-logitech-hidpp.ko` file using `zstd`, and move the resulting `hid-logitech-hidpp.ko.zst` file to the <code>/lib/modules/\`uname -r\`/kernel/drivers/hid</code>[^2] directory.

[^1]: N.B.: I have not tested with any mouse except the MX Master 3.
[^2]: `uname -r` is a shell command that outputs the release of the currently running kernel, e.g. 5.17.5-arch1-1.

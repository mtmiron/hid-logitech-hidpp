# Logitech MX Master 3 mouse in Arch Linux
This is a quick-and-dirty setup to build the hid-logitech-hidpp driver, which is used by the Logitech MX Master 3 wireless mouse.  It's built as an out-of-tree module.

## Why? (aka "The problem")
When using the stock kernel driver, as provided by Logitech, the mouse wheel of the Logitech MX Master 3 ignores the first input whenever the mouse wheel changes its direction, i.e. if you're scrolling down and then try to scroll up, the Logitech driver does nothing for the first upward "click" of the wheel.  This makes the mouse feel clunky and unresponsive.  I found this incredibly irritating, so I modified the driver source code and threw together a build script so I could replace my kernel module.

To read more about this issue and why it was implemented as a work around, I've quoted the applicable portion of the kernel submission notes below.  From [https://lwn.net/Articles/772785/](https://lwn.net/Articles/772785/):

```
Notable: The Logitech REL_WHEEL emulation cannot just hook into the HID
bits. The firmware drops some events so the point when we get the REL_WHEEL
event moves around. This is worked around by directional resets and a
timeout-based reset.
```

I've noticed no "drifting" of the relative wheel motion being reported (nor, to be frank, do I understand how a relative motion can have a fixed point in order for that point to drift at all).  YMMV.


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

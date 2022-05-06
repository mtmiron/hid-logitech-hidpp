# Logitech MX Master 3 mouse in Arch Linux
This is a quick-and-dirty setup to build the hid-logitech-hidpp driver, which is used by the Logitech MX Master 3 wireless mouse.  It's built as an out-of-tree module.

## Why? (aka "The problem")
When using the stock kernel driver, as provided by Logitech, the mouse wheel of the Logitech MX Master 3 ignores the first input whenever the mouse wheel changes its direction, i.e. if you're scrolling down and then try to scroll up, the Logitech driver does nothing for the first upward "click" of the wheel.  This makes the mouse feel clunky and unresponsive.  I found this incredibly irritating, so I modified the driver source code and threw together a build script so I could replace my kernel module.

## Compiling the module
Ensure that the current working directory is the root of this repository (the directory with the `hid-logitech-hidpp.c` file).  Then type:
```
make
```

For further information, see [https://www.kernel.org/doc/Documentation/kbuild/modules.txt](https://www.kernel.org/doc/Documentation/kbuild/modules.txt "kbuild documentation")

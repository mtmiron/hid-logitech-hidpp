ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
include Kbuild

else
# normal makefile
KDIR ?= /lib/modules/`uname -r`/build
build = $(MAKE) -C $(KDIR) M=$$PWD $1

.PHONY: clean help modules_install

default: hid-logitech-hidpp.c
	$(call build,)

help clean modules:
	$(call build,$@)

modules_install: default
	$(call build,$@)

endif

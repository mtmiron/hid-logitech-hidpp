ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
include Kbuild

else
# normal makefile
KDIR ?= /lib/modules/`uname -r`/build
build = $(MAKE) -C $(KDIR) M=$$PWD $1

.PHONY: clean default help modules modules_install
default:
	$(call build,)

help clean modules modules_install:
	$(call build,$@)

endif

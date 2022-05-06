ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
include Kbuild

else
# normal makefile
KDIR ?= /lib/modules/`uname -r`/build
build = $(MAKE) -C $(KDIR) M=$$PWD $1

.PHONY: clean default help
default:
	$(call build,)

help clean:
	$(call build,$@)

endif

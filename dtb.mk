#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# dtb.img and dtbo.img are packed from the DTBs the kernel build already
# produces in KERNEL_OBJ, configured with TARGET_KERNEL_ADDITIONAL_CONFIG.

F21PRO_DTS_OUT := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/dts/mediatek

$(F21PRO_DTS_OUT)/mt6761.dtb $(F21PRO_DTS_OUT)/f21pro.dtbo: $(TARGET_PREBUILT_INT_KERNEL)
	@true

# dtb.img: core/Makefile concatenates $(BOARD_PREBUILT_DTBIMAGE_DIR)/*.dtb
$(PRODUCT_OUT)/dtb.img: $(F21PRO_DTS_OUT)/mt6761.dtb

# dtbo.img
MKDTBOIMG := $(HOST_OUT_EXECUTABLES)/mkdtboimg.py$(HOST_EXECUTABLE_SUFFIX)
$(BOARD_PREBUILT_DTBOIMAGE): $(MKDTBOIMG) $(F21PRO_DTS_OUT)/f21pro.dtbo
	@echo "Building dtbo.img"
	$(hide) mkdir -p $(dir $@)
	$(MKDTBOIMG) create $@ --page_size=$(BOARD_KERNEL_PAGESIZE) $(F21PRO_DTS_OUT)/f21pro.dtbo

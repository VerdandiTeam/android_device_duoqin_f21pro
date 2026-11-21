#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/duoqin/f21pro

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := f21pro
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 208

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
# Layout verified: repacking stock parts with these is byte-identical to boot_a.bin
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_OFFSET := 0x00080000
BOARD_RAMDISK_OFFSET := 0x11b00000
BOARD_KERNEL_TAGS_OFFSET := 0x07880000
BOARD_DTB_OFFSET := 0x07880000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image.gz

# Built from source. On SailfishOS only the kernel + dtb are used: hybris-boot
# packs them (dtb.img is passed as --dtb because of BOARD_INCLUDE_DTB_IN_BOOTIMG).
TARGET_KERNEL_SOURCE := kernel/duoqin/mt6761
TARGET_KERNEL_CONFIG := k61v1_64_bsp_defconfig
# = duoqin_f21pro.config + duoqin_f21pro_sfos.config (18.1 takes only one fragment)
TARGET_KERNEL_ADDITIONAL_CONFIG := duoqin_f21pro_hybris.config
TARGET_KERNEL_CLANG_COMPILE := true
# Kernel is configured for LLD/LLVM binutils (CONFIG_LD_IS_LLD), like stock
TARGET_KERNEL_ADDITIONAL_FLAGS := LD=ld.lld NM=llvm-nm OBJCOPY=llvm-objcopy
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# DTBO: stock image (boot-tested with our kernel); flashed separately to dtbo_X
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SUPER_PARTITION_SIZE := 4294967296
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := system vendor product
# Virtual A/B: one group nearly the full super (stock main_a = 4292870144)
BOARD_MAIN_SIZE := 4292870144

# Platform
TARGET_BOARD_PLATFORM := mt6761

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6761
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor

# Security patch level
VENDOR_SECURITY_PATCH := 2020-12-05

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Inherit the proprietary files
include vendor/duoqin/f21pro/BoardConfigVendor.mk

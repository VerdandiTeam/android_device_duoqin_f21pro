#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from f21pro device
$(call inherit-product, device/duoqin/f21pro/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := f21pro
PRODUCT_NAME := lineage_f21pro
PRODUCT_BRAND := Qin
PRODUCT_MODEL := F21 Pro
PRODUCT_MANUFACTURER := duoqin

PRODUCT_GMS_CLIENTID_BASE := android-duoqin

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="full_k61v1_64_gms-user 11 RP1A.200720.011 410 release-keys" \
    BuildFingerprint=Qin/full_k61v1_64_gms/k61v1_64_bsp:11/RP1A.200720.011/410:user/release-keys

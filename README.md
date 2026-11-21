# Device tree for Duoqin (Qin) F21 Pro — `f21pro`

LineageOS 18.1 / hybris-18.1 (Android 11) device tree, intended as the base
for a SailfishOS port. Generated from the stock firmware with `aospdtgen`
and fixed up by hand.

| | |
|---|---|
| SoC | MediaTek Helio A22 (MT6761), 4x Cortex-A53 |
| Stock firmware | Android 11 (SDK 30), `A666_V0.0.5_20250613`, security patch 2020-12-05 |
| Stock codename | `k61v1_64_bsp` (MediaTek reference board name — not unique, so this tree uses `f21pro`) |
| Kernel | 4.19.127 — `android_kernel_duoqin_mt6761` |
| Display | 480x640, 208 dpi |
| Partitions | A/B, **Virtual A/B**, dynamic partitions (4 GiB `super`, group `main`: system, vendor, product) |
| Boot | header v2, no `vendor_boot`, recovery-as-boot, DTB in boot header |
| Encryption | stock uses FBE v2 + metadata encryption |

## Boot image layout

Verified: repacking the stock kernel, ramdisk and DTB with these values is
byte-identical to stock `boot_a`.

```
base 0x40000000  kernel_offset 0x00080000  ramdisk_offset 0x11b00000
tags_offset 0x07880000  dtb_offset 0x07880000  pagesize 2048  header_version 2
cmdline: bootopt=64S3,32N2,64N2 buildvariant=user
```

## Kernel

Built from source: [`android_kernel_duoqin_mt6761`](https://github.com/JamiKettunen/android_kernel_duoqin_mt6761)
checked out at `kernel/duoqin/mt6761`, using `k61v1_64_bsp_defconfig` +
`duoqin_f21pro_hybris.config` (the F21 Pro fragment + SailfishOS fragment
combined, since LineageOS 18.1 takes a single additional fragment), clang +
LLD. On SailfishOS the kernel and `dtb.img` are packed by hybris-boot.

`prebuilts/dtbo.img` is the stock DTBO.

## Proprietary blobs

```sh
./extract-files.sh <path-to-stock-dump>   # or: ./extract-files.sh (adb)
```

The dump directory must have `system/`, `vendor/`, `product/`, `odm/`,
`system_ext/` at the top level (system-as-root dumps: point `system` at the
inner `system/system`). Blobs land in
[`android_vendor_duoqin_f21pro`](../../../vendor/duoqin/f21pro).

## Status / TODO

- [x] Device tree generated, boot layout / super / fstab fixed
- [x] Vendor blobs extracted (1307 entries)
- [ ] First hybris-18.1 build
- [ ] Prune `/system` blobs from `proprietary-files.txt` (only `/vendor` + `/odm` should be needed with Treble)
- [x] In-tree kernel build (kernel/duoqin/mt6761, `duoqin_f21pro_hybris.config`)
- [ ] SailfishOS: droid-hal-f21pro, droid-config-f21pro, fixup-mountpoints

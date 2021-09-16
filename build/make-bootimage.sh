#!/bin/bash
set -ex

KERNEL_OBJ=$(realpath $1)
RAMDISK=$(realpath $2)
OUT=$(realpath $3)

HERE=$(pwd)
source "${HERE}/deviceinfo"

case "$deviceinfo_arch" in
    aarch64*) ARCH="arm64" ;;
    arm*) ARCH="arm" ;;
    x86_64) ARCH="x86_64" ;;
    x86) ARCH="x86" ;;
esac

[ -f "$HERE/ramdisk-recovery.img" ] && RECOVERY_RAMDISK="$HERE/ramdisk-recovery.img"
[ -f "$HERE/ramdisk-overlay/ramdisk-recovery.img" ] && RECOVERY_RAMDISK="$HERE/ramdisk-overlay/ramdisk-recovery.img"

if [ -d "$HERE/ramdisk-recovery-overlay" ] && [ -e "$RECOVERY_RAMDISK" ]; then
    mkdir -p "$HERE/ramdisk-recovery"

    cd "$HERE/ramdisk-recovery"
    gzip -dc "$RECOVERY_RAMDISK" | cpio -i
    cp -r "$HERE/ramdisk-recovery-overlay"/* "$HERE/ramdisk-recovery"

    find . | cpio -o -H newc | gzip >> "$RECOVERY_RAMDISK"
fi

if [ -d "$HERE/ramdisk-overlay" ]; then
    cp "$RAMDISK" "${RAMDISK}-merged"
    RAMDISK="${RAMDISK}-merged"
    cd "$HERE/ramdisk-overlay"
    find . | cpio -o -H newc | gzip >> "$RAMDISK"
fi

if [ "$deviceinfo_bootimg_header_version" -eq 2 ]; then
    IMAGE_LIST="Image.gz Image"
else
    IMAGE_LIST="Image.gz-dtb Image.gz Image"
fi

for image in $IMAGE_LIST; do
    if [ -e "$KERNEL_OBJ/arch/$ARCH/boot/$image" ]; then
        KERNEL="$KERNEL_OBJ/arch/$ARCH/boot/$image"
        break
    fi
done

if [ -n "$deviceinfo_prebuilt_dtbo" ]; then
    DTBO="$HERE/$deviceinfo_prebuilt_dtbo"
elif [ -n "$deviceinfo_dtbo" ]; then
    DTBO="$(dirname "$OUT")/dtbo.img"
fi

if [ "$deviceinfo_bootimg_header_version" -eq 2 ]; then
    mkbootimg --kernel "$KERNEL" --ramdisk "$RAMDISK" --dtb "$HERE/$deviceinfo_bootimg_prebuilt_dtb" --base $deviceinfo_flash_offset_base --kernel_offset $deviceinfo_flash_offset_kernel --ramdisk_offset $deviceinfo_flash_offset_ramdisk --second_offset $deviceinfo_flash_offset_second --tags_offset $deviceinfo_flash_offset_tags --dtb_offset $deviceinfo_flash_offset_dtb --pagesize $deviceinfo_flash_pagesize --cmdline "$deviceinfo_kernel_cmdline" -o "$OUT" --header_version $deviceinfo_bootimg_header_version --os_version $deviceinfo_bootimg_os_version --os_patch_level $deviceinfo_bootimg_os_patch_level
else
    mkbootimg --kernel "$KERNEL" --ramdisk "$RAMDISK" --base $deviceinfo_flash_offset_base --kernel_offset $deviceinfo_flash_offset_kernel --ramdisk_offset $deviceinfo_flash_offset_ramdisk --second_offset $deviceinfo_flash_offset_second --tags_offset $deviceinfo_flash_offset_tags --pagesize $deviceinfo_flash_pagesize --cmdline "$deviceinfo_kernel_cmdline" -o "$OUT"
fi

if [ -n "$deviceinfo_has_recovery_partition" ] && $deviceinfo_has_recovery_partition; then
    RECOVERY="$(dirname "$OUT")/recovery.img"
    RECOVERY_RAMDISK="$HERE/ramdisk-recovery.img"
    EXTRA_ARGS=""

    if [ "$deviceinfo_bootimg_header_version" -eq 2 ]; then
        EXTRA_ARGS+=" --header_version $deviceinfo_bootimg_header_version --dtb $DTB --dtb_offset $deviceinfo_flash_offset_dtb"
    fi

    if [ -n "$DTBO" ]; then
        EXTRA_ARGS+=" --recovery_dtbo $DTBO"
    fi

    mkbootimg --kernel "$KERNEL" --ramdisk "$RECOVERY_RAMDISK" --base $deviceinfo_flash_offset_base --kernel_offset $deviceinfo_flash_offset_kernel --ramdisk_offset $deviceinfo_flash_offset_ramdisk --second_offset $deviceinfo_flash_offset_second --tags_offset $deviceinfo_flash_offset_tags --pagesize $deviceinfo_flash_pagesize --cmdline "$deviceinfo_kernel_cmdline" -o "$RECOVERY" --os_version $deviceinfo_bootimg_os_version --os_patch_level $deviceinfo_bootimg_os_patch_level $EXTRA_ARGS
fi

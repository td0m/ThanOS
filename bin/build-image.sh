#!/bin/sh
efi_file="$1"
img="$2"

loopback_dev="/dev/loop1"

sudo rm $img

# create disk image full of 0s
sudo dd if=/dev/zero of=$img bs=512 count=93750
# create GPT headers with an EFI partition
sudo parted $img -s -a minimal mklabel gpt
sudo parted $img -s -a minimal mkpart EFI FAT32 2048s 93716s
sudo parted $img -s -a minimal toggle 1 boot
# select $loopback_dev as loopback device
sudo losetup --offset 1048576 --sizelimit 46934528 $loopback_dev $img
sudo mkdosfs -F 32 $loopback_dev
# mount file system and copy .efi file
sudo mount $loopback_dev /mnt
sudo mkdir -p /mnt/EFI/BOOT
sudo cp $efi_file /mnt/EFI/BOOT/bootx64.efi
# unmount and free loopback device
sudo umount /mnt
sudo losetup -d $loopback_dev

# ThanOS

## Summary

ThanOS is an experimental OS written in Rust, currently implemented for the `x86_64` platform running on **UEFI**.

Its goal is to build a simple, portable OS to investigate the fundamentals building of a kernel.

## Requirements

 - Linux `x86_64`
 - `qemu` (`qemu-system-x86_64`)
 - `make`
 - `rust`
 - `OVMF.fd` (for running UEFI binaries in **QEMU**) - placed in the `bin` directory, you might have to compile that yourself

## Building

Firstly, clone this repo:
```bash
git clone https://github.com/d0minikt/ThanOS
cd ThanOS
make install
```

Now you can run this in QEMU:
```bash
make qemu
```

Or build the image and flash it on a USB stick:
```bash
make build-image
sudo dd if=build/debug.img of=/dev/sda bs=4M status=progress
```

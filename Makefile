install:
	cargo install cargo-xbuild

compile:
	cargo xbuild --target x86_64-unknown-uefi

build-image: compile
	./bin/build-image.sh \
		target/x86_64-unknown-uefi/debug/thanos.efi \
		build/debug.img

qemu: build-image
	sudo qemu-system-x86_64 \
		-cpu qemu64 \
		-bios bin/OVMF.fd \
		-drive file=build/debug.img,format=raw \
		-net none


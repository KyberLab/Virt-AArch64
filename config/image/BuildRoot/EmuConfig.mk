#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




#QEMU_STORAGE_TYPE			:= none
#QEMU_NETWORK_TYPE			:= none


IMAGE_BOOT_BIN				:= $(OUTPUT_ROOT_PATH)/BuildRoot-Kernel.bin

IMAGE_RUN_ARGS				+= \
	-kernel $(IMAGE_BOOT_BIN) \
	-drive file=$(OUTPUT_ROOT_PATH)/BuildRoot-RootFS.ext4,if=none,format=raw,id=buildroot \
	-device virtio-blk-device,drive=buildroot \
	-append "rootwait root=/dev/vdd loglevel=8"
#	-append "rootwait root=/dev/vda console=ttyAMA3 loglevel=8"


# qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 -kernel Image -append "rootwait root=/dev/vda console=ttyAMA0" -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 -drive file=rootfs.ext4,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0


#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




#QEMU_STORAGE_TYPE			:= none

IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/BusyBox-Initrd.cpio.gz
IMAGE_LINUX_BIN				?= $(OUTPUT_ROOT_PATH)/Linux.bin


IMAGE_RUN_ARGS				+= \
	-kernel $(IMAGE_LINUX_BIN) \
	-initrd ${IMAGE_BOOT_BIN} \
	-append "root=/dev/ram0 rw rdinit=/sbin/init earlyprintk=serial,ttyAMA3 console=ttyAMA3 ramdisk_size=2048000"


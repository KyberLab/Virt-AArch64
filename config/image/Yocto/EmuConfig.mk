#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#





QEMU_MACHINE_TYPE			:= virt,gic-version=3,virtualization=on,iommu=smmuv3,secure=off
QEMU_CPU_TYPE				:= cortex-a72


QEMU_TERM_TYPE				:= none
QEMU_STORAGE_TYPE			:= none
QEMU_NETWORK_TYPE			:= none
QEMU_GRAPHIC_TYPE			:= none
#QEMU_GRAPHIC_ARGS			:= -nographic

IMAGE_YOCTO_DEBUG			?= 0


IMAGE_YOCTO_UEFI_CODE		:= EDK2_UEFI_PFLASH0.img
IMAGE_YOCTO_UEFI_DATA		:= EDK2_UEFI_PFLASH1.img

IMAGE_YOCTO_FILE_NAME		:= Yocto-AArch64.qcow2

ifeq ($(IMAGE_YOCTO_DEBUG),0)
IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_FILE_NAME)
else
IMAGE_BOOT_BIN				?= $(BUILD_ROOT_PATH)/Yocto/build/$(IMAGE_YOCTO_FILE_NAME)
endif

IMAGE_RUN_ARGS				+= \
	-drive if=pflash,format=raw,readonly=on,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_UEFI_CODE) \
	-drive if=pflash,format=raw,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_UEFI_DATA) \
	-drive file=$(IMAGE_BOOT_BIN),format=qcow2,id=yocto,if=none \
	-device virtio-blk-device,drive=yocto,bootindex=0 \
	-device virtio-gpu-pci -display gtk,gl=off


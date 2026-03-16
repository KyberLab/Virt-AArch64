#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




QEMU_TERM_TYPE				:= none
QEMU_STORAGE_TYPE			:= none
QEMU_NETWORK_TYPE			:= none
QEMU_GRAPHIC_TYPE			:= pcie
#QEMU_GRAPHIC_ARGS			:= -nographic



IMAGE_YOCTO_UEFI_CODE		:= UbuntuPFlash0.img
IMAGE_YOCTO_UEFI_DATA		:= UbuntuPFlash1.img

IMAGE_YOCTO_FILE_NAME		:= Yocto-AArch64.qcow2
IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_FILE_NAME)


IMAGE_RUN_ARGS				+= \
	-drive if=pflash,format=raw,readonly=on,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_UEFI_CODE) \
	-drive if=pflash,format=raw,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_UEFI_DATA) \
	-drive file=$(IMAGE_BOOT_BIN),format=qcow2,id=yocto,if=none \
	-device virtio-blk,drive=yocto,bootindex=0



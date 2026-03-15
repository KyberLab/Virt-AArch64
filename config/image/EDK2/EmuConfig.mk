#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




QEMU_GRAPHIC_TYPE			:= none
QEMU_GRAPHIC_ARGS			:= -nographic

IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/EDK2_UEFI_PFLASH0.img

IMAGE_EDK2_UEFI_CODE		:= EDK2_UEFI_CODE.img
IMAGE_EDK2_UEFI_VARS		:= EDK2_UEFI_VARS.img

IMAGE_EDK2_UEFI_PFLASH0		:= EDK2_UEFI_PFLASH0.img
IMAGE_EDK2_UEFI_PFLASH1		:= EDK2_UEFI_PFLASH1.img

IMAGE_UBUNTU_SYSTEM			:= UbuntuSystem.qcow2
IMAGE_UBUNTU_METADATA_ISO	:= UbuntuMetadata.iso


IMAGE_RUN_ARGS				+= \
	-drive if=pflash,format=raw,readonly=on,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_EDK2_UEFI_PFLASH0) \
	-drive if=pflash,format=raw,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_EDK2_UEFI_PFLASH1) \
	-cdrom $(OUTPUT_ROOT_PATH)/$(IMAGE_UBUNTU_METADATA_ISO) \
	-drive file=$(OUTPUT_ROOT_PATH)/$(IMAGE_UBUNTU_SYSTEM),format=qcow2,id=ubuntu,if=none \
	-device virtio-blk,drive=ubuntu,bus=pcie.0,addr=0x01


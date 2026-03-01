#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




IMAGE_UBUNTU_UEFI_FW		:= QEMU_EFI.fd
IMAGE_UBUNTU_UEFI_CODE		:= UbuntuPFlash0.img
IMAGE_UBUNTU_UEFI_DATA		:= UbuntuPFlash1.img


IMAGE_UBUNTU_BASE			:= UbuntuBase.qcow2
IMAGE_UBUNTU_SYSTEM			:= UbuntuSystem.qcow2
IMAGE_UBUNTU_METADATA		:= UbuntuMetadata.iso
IMAGE_UBUNTU_USERDATA		:= user-data
IMAGE_UBUNTU_METADATA		:= meta-data



IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/$(IMAGE_UBUNTU_SYSTEM)


IMAGE_RUN_ARGS				+= \
	-drive if=pflash,format=raw,readonly=on,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_UBUNTU_UEFI_CODE) \
	-drive if=pflash,format=raw,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_UBUNTU_UEFI_DATA) \
	-cdrom $(OUTPUT_ROOT_PATH)/$(IMAGE_UBUNTU_METADATA) \
	-drive file=$(IMAGE_BOOT_BIN),format=qcow2,id=ubuntu,if=none \
	-device virtio-blk,drive=ubuntu,bus=pcie.0,addr=0x01


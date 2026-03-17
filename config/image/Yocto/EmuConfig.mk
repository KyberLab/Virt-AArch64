#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#



# First run config
# UEFI # bcfg boot dump
# UEFI # bcfg boot rm 1
# UEFI # bcfg boot rm 2
# UEFI $ bcfg boot add 1 fs0:\grubaa64.efi "Grub Bootloader"
# UEFI $ bcfg boot add 2 fs0:\xen-qemuarm64.efi "Xen Hypervisor"
# UEFI $ reset

# Dump DTB
# make emu_yocto QEMU_DTB_DUMP=1


QEMU_MACHINE_TYPE			:= virt,gic-version=3,virtualization=on,iommu=smmuv3,accel=tcg,secure=off
QEMU_CPU_TYPE				:= cortex-a72,pmu=on


QEMU_TERM_TYPE				:= none
QEMU_STORAGE_TYPE			:= none
QEMU_NETWORK_TYPE			:= none
QEMU_GRAPHIC_TYPE			:= none
#QEMU_GRAPHIC_ARGS			:= -nographic


IMAGE_YOCTO_DEBUG			?= 0
#YOCTO_BOOT_TYPE				:= uefi


IMAGE_YOCTO_UEFI_CODE		:= EDK2_UEFI_PFLASH0.img
IMAGE_YOCTO_UEFI_DATA		:= EDK2_UEFI_PFLASH1.img

IMAGE_YOCTO_FILE_NAME		:= Yocto-AArch64.qcow2

ifeq ($(IMAGE_YOCTO_DEBUG),0)
IMAGE_YOCTO_SYSTEM_FILE		?= $(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_FILE_NAME)
else # ($(IMAGE_YOCTO_DEBUG),0)
IMAGE_YOCTO_SYSTEM_FILE		?= $(BUILD_ROOT_PATH)/Yocto/build/$(IMAGE_YOCTO_FILE_NAME)
endif # ($(IMAGE_YOCTO_DEBUG),0)


ifeq ($(YOCTO_BOOT_TYPE),uefi)

IMAGE_BOOT_BIN				:= $(IMAGE_YOCTO_SYSTEM_FILE)

IMAGE_RUN_ARGS				+= \
	-drive if=pflash,format=raw,readonly=on,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_UEFI_CODE) \
	-drive if=pflash,format=raw,file=$(OUTPUT_ROOT_PATH)/$(IMAGE_YOCTO_UEFI_DATA)

#IMAGE_RUN_ARGS				+= \
#	-dtb $(OUTPUT_ROOT_PATH)/virt-aarch64.dtb

else # ifeq ($(YOCTO_BOOT_TYPE),uefi)

IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/Yocto-Image.bin

IMAGE_RUN_ARGS				+= \
	-kernel $(IMAGE_BOOT_BIN) \
	-append "root=/dev/vda3 rw console=ttyAMA3,115200 earlycon=pl011,0x09000000 init=/sbin/init rootfstype=ext4"

endif # ifeq ($(YOCTO_BOOT_TYPE),uefi)


IMAGE_RUN_ARGS				+= \
	-drive file=$(IMAGE_YOCTO_SYSTEM_FILE),format=qcow2,id=yocto,if=none \
	-device virtio-blk-device,drive=yocto,bootindex=0

IMAGE_RUN_ARGS				+= \
	-device virtio-gpu-pci,iommu_platform=on,ats=on -display gtk,gl=off \


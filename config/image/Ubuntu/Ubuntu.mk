#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




$(eval $(call rule_inc,$(CONFIG_IMAGE_PATH)/$(IMAGE_BUILD_GOAL)/EmuConfig.mk))


# (Required) Build type
IMAGE_BUILD_TYPE			:= Ubuntu


# (Required) Fetch options
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-arm64.img:$(IMAGE_UBUNTU_BASE):f1a64db84c980f24f0ff6e7bfbbf1084
IMAGE_FETCH_URL				+= https://github.com/rohan-qemu/firmware/raw/master/bios/QEMU_EFI.fd:$(IMAGE_UBUNTU_UEFI_FW):b797ff2c1da88d15512e4b74a3ca1e6d
IMAGE_FETCH_REF				:= 

# (Optional) Patch options
IMAGE_PATCH_OPTS			:= 

# (Required) Config options
IMAGE_CONFIG_OPTS			:= 

# (Optional) Build options
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= $(IMAGE_UBUNTU_UEFI_CODE) $(IMAGE_UBUNTU_UEFI_DATA)
IMAGE_INSTALL_LIST			+= $(IMAGE_UBUNTU_METADATA) $(IMAGE_UBUNTU_BASE) $(IMAGE_UBUNTU_SYSTEM)

# (Optional) Package options
IMAGE_PACKAGE_OPTS			:= 
IMAGE_PACKAGE_LIST			:= $(IMAGE_UBUNTU_UEFI_CODE) $(IMAGE_UBUNTU_UEFI_DATA)
IMAGE_PACKAGE_LIST			+= $(IMAGE_UBUNTU_METADATA) $(IMAGE_UBUNTU_BASE) $(IMAGE_UBUNTU_SYSTEM)

# (Optional) Clean options
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
IMAGE_DISTCLEAN_OPTS		:= 



###############################################################################
# Image Build Variables (Optional)

IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_UEFI_FW=$(IMAGE_UBUNTU_UEFI_FW)
IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_UEFI_CODE=$(IMAGE_UBUNTU_UEFI_CODE)
IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_UEFI_DATA=$(IMAGE_UBUNTU_UEFI_DATA)

IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_BASE=$(IMAGE_UBUNTU_BASE)
IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_SYSTEM=$(IMAGE_UBUNTU_SYSTEM)
IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_METADATA=$(IMAGE_UBUNTU_METADATA)
IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_USERDATA=$(IMAGE_UBUNTU_USERDATA)
IMAGE_EXPORT_ENV			+= IMAGE_UBUNTU_METADATA=$(IMAGE_UBUNTU_METADATA)


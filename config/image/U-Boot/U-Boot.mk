#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# (Required) Build type
IMAGE_BUILD_TYPE			:= U-Boot


# (Required) Fetch options
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(IMAGE_UBOOT_URL)
IMAGE_FETCH_REF				:= $(IMAGE_UBOOT_REF)

# (Optional) Patch options
IMAGE_PATCH_OPTS			:= 

# (Optional) Config options
IMAGE_CONFIG_OPTS			:= qemu_arm64_defconfig

# (Optional) Build options
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= build/u-boot.bin:u-boot.bin build/U-Boot.img:U-Boot.img

# (Optional) Package options
IMAGE_PACKAGE_OPTS			:= 
IMAGE_PACKAGE_LIST			:= U-Boot.img u-boot.bin

# (Optional) Clean options
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
IMAGE_DISTCLEAN_OPTS		:= 



###############################################################################
# Image Build Variables (Optional)

IMAGE_EXPORT_ENV			+= ARCH=arm64
IMAGE_EXPORT_ENV			+= CROSS_COMPILE=aarch64-none-elf-


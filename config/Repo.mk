#                                 KyberVirt
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# U-Boot Repo Config

IMAGE_UBOOT_URL				?= $(REPO_URL_GIT_BASE)/u-boot.git

ifneq ($(BUILD_TYPE_STR),release)
IMAGE_UBOOT_REF				?= kyberlab/v2026.01/develop
else
IMAGE_UBOOT_REF				?= v2026.01
endif



###############################################################################
# Linux Repo Config

IMAGE_LINUX_URL				?= $(REPO_URL_GIT_BASE)/linux.git

ifneq ($(BUILD_TYPE_STR),release)
IMAGE_LINUX_REF				?= kyberlab/v6.19/develop
else
IMAGE_LINUX_REF				?= v6.19
endif



###############################################################################
# BusyBox Repo Config

IMAGE_BUSYBOX_URL			?= $(REPO_URL_GIT_BASE)/busybox.git

ifneq ($(BUILD_TYPE_STR),release)
IMAGE_BUSYBOX_REF			?= kyberlab/1_36_1/develop
else
IMAGE_BUSYBOX_REF			?= 1_36_1
endif



###############################################################################
# BuildRoot Repo Config

IMAGE_BUILDROOT_URL	?= $(REPO_URL_GIT_BASE)/buildroot.git

ifneq ($(BUILD_TYPE_STR),release)
IMAGE_BUILDROOT_REF			?= kyberlab/2025.11.2/develop
else
IMAGE_BUILDROOT_REF			?= 2025.11.2
endif



###############################################################################
# Emu Repo Config

IMAGE_EMU_URL				?= $(REPO_URL_GIT_BASE)/KyberEmu.git

ifneq ($(BUILD_TYPE_STR),release)
IMAGE_EMU_REF				?= develop
else
IMAGE_EMU_REF				?= master
endif



###############################################################################
# Qemu Repo Config

IMAGE_QEMU_URL				?= $(REPO_URL_GIT_BASE)/qemu.git

ifneq ($(BUILD_TYPE_STR),release)
IMAGE_QEMU_REF				?= kyberlab/v10.2.0/develop
else
IMAGE_QEMU_REF				?= v10.2.0
endif



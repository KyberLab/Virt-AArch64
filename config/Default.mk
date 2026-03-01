#                                 KyberVirt
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Build Config

BUILD_PLATFORM				:= qemu
BUILD_BOARD					:= virt-aarch64

BUILD_TYPE_NUM				?= 3
BUILD_TYPE_STR				?= test
BUILD_VARIANT				?= Community

IMAGE_BUILD_LIST			?= U-Boot Linux BusyBox BuildRoot Ubuntu KyberEmu
IMAGE_DEPEND_LIST			?= 



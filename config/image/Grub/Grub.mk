#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#


# https://packages.debian.org/sid/grub-efi-arm64-unsigned
# https://packages.debian.org/sid/arm64/grub-efi-arm64-unsigned/download
# wget http://ftp.cn.debian.org/debian/pool/main/g/grub2/grub-efi-arm64-unsigned_2.14-2_arm64.deb
# dpkg-deb -x grub-efi-arm64-unsigned_2.14-2_arm64.deb ./grub-bin
# cp grub-bin/usr/lib/grub/arm64-efi/monolithic/grubaa64.efi .


# (Required) Build type
IMAGE_BUILD_TYPE			:= AutoMake

# (Required) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(REPO_URL_GIT_BASE)/grub.git
IMAGE_FETCH_REF				:= grub-2.12

# (Optional) Patch options
#IMAGE_PATCH_METHOD			:= 
IMAGE_PATCH_OPTS			:= 

# (Required) Config options
#IMAGE_CONFIG_METHOD		:= 
IMAGE_CONFIG_OPTS			:= --host=aarch64-none-linux-gnu --target=aarch64 --with-platform=efi --disable-werror --enable-grub-mount=no --enable-grub-mkfont=no

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= 
# -j$(shell nproc)

# (Optional) Install options
#IMAGE_INSTALL_METHOD		:= 
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= 

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= 
IMAGE_PACKAGE_OPTS			:= 
IMAGE_PACKAGE_LIST			:= 

# (Optional) Clean options
#IMAGE_CLEAN_METHOD			:= 
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
#IMAGE_DISTCLEAN_METHOD		:= 
IMAGE_DISTCLEAN_OPTS		:= 

# (Optional) Action options
#IMAGE_ACTION_METHOD		:= 
IMAGE_ACTION_OPTS			:= 


# (Optional) Extra step

IMAGE_EXPORT_ENV			+= ARCH=arm64
IMAGE_EXPORT_ENV			+= CROSS_COMPILE=aarch64-none-linux-gnu-


# image_prerun_config
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_prerun_config
	$(IQ)cd $(3) && ./bootstrap
endef


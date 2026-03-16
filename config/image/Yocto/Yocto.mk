#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




$(eval $(call rule_inc,$(CONFIG_IMAGE_PATH)/$(IMAGE_BUILD_GOAL)/EmuConfig.mk))


YOCTO_BUILD_TYPE			?= sato
YOCTO_BUILD_IMAGE			?= core-image-$(YOCTO_BUILD_TYPE)
YOCTO_BUILD_BRANCH			?= kyberlab/styhead/develop


# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Required) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(REPO_URL_GIT_BASE)/poky.git
IMAGE_FETCH_REF				:= $(YOCTO_BUILD_BRANCH)

# (Optional) Patch options
IMAGE_PATCH_METHOD			:= file
IMAGE_PATCH_OPTS			:= 

# (Required) Config options
#IMAGE_CONFIG_METHOD		:= 
IMAGE_CONFIG_OPTS			:= 

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
#IMAGE_INSTALL_METHOD		:= 
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= build/$(IMAGE_YOCTO_FILE_NAME):$(IMAGE_YOCTO_FILE_NAME)

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= 
IMAGE_PACKAGE_OPTS			:= build/$(IMAGE_YOCTO_FILE_NAME):$(IMAGE_YOCTO_FILE_NAME)
IMAGE_PACKAGE_LIST			:= 

# (Optional) Clean options
#IMAGE_CLEAN_METHOD			:= 
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
#IMAGE_DISTCLEAN_METHOD		:= 
IMAGE_DISTCLEAN_OPTS		:= 

# (Optional) Action options
IMAGE_ACTION_METHOD			:= custom
IMAGE_ACTION_OPTS			:= 


# (Optional) Extra step

# image_postrun_fetch
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_postrun_fetch
	$(IQ)cd $(3) && \
		git clone $(REPO_URL_GIT_BASE)/meta-openembedded.git -b $(YOCTO_BUILD_BRANCH) && \
		git clone $(REPO_URL_GIT_BASE)/meta-virtualization.git -b $(YOCTO_BUILD_BRANCH)
endef


# image_custom_config
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_config
	$(IQ)cd $(3) && . ./oe-init-build-env
endef


# image_custom_build
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_build
	$(IQ)cd $(3) && . ./oe-init-build-env && \
		bitbake $(if $(1),$(1),$(YOCTO_BUILD_IMAGE)) && \
		$(if $(1),exit 0,bitbake xen)
endef


# qemu_image_create
# $(1) qemu image file path
# $(2) image format
# $(3) image size
define qemu_image_create
	$(IQ)qemu-img create -f $(2) $(1) $(3)
	$(IQ)qemu-img info $(1)
endef


# yocto_image_mount
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_mount
	$(IQ)$(call nbd_dev_init,$(5))
	$(IQ)$(call nbd_dev_disconnect,$(5))
	$(IQ)$(call nbd_dev_connect,$(5),$(1))
	$(IQ)$(call nbd_dev_part_mknode,$(6))
	$(IQ)sudo mkdir -pv /mnt/{boot,mini,sato,data} && \
		sudo mount /dev/$(6)p1 /mnt/boot && \
		sudo mount /dev/$(6)p2 /mnt/mini && \
		sudo mount /dev/$(6)p3 /mnt/sato && \
		sudo mount /dev/$(6)p4 /mnt/data && \
		df -hT | grep nbd
endef


# yocto_image_umount
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_umount
	$(IQ)$(call nbd_dev_init,$(5))
	$(IQ)$(call nbd_dev_part_mknode,$(6))
	$(IQ)$(call nbd_dev_part_print,$(5),$(6))
	$(IQ)sudo umount /mnt/{boot,mini,sato,data}
	$(IQ)$(call nbd_dev_part_rmnode,$(6))
	$(IQ)$(call nbd_dev_disconnect,$(5))
endef


# yocto_image_create
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_create
	$(IQ)$(call nbd_dev_init,$(5))
	$(IQ)$(call nbd_dev_disconnect,$(5))
	$(IQ)$(call qemu_image_create,$(1),$(2),$(3))
	$(IQ)$(call nbd_dev_connect,$(5),$(1))
	$(IQ)$(call nbd_dev_part,$(5),$(4))
	$(IQ)$(call nbd_dev_part_mknode,$(6))
	$(IQ)$(call nbd_dev_format,$(5),$(6),1,vfat,-F32)
	$(IQ)$(call nbd_dev_format,$(5),$(6),2,ext4)
	$(IQ)$(call nbd_dev_format,$(5),$(6),3,ext4)
	$(IQ)$(call nbd_dev_format,$(5),$(6),4,ext4)
	$(IQ)sudo mkdir -pv /mnt/{boot,mini,sato,data} && \
		sudo mount /dev/$(6)p1 /mnt/boot && \
		sudo mount /dev/$(6)p2 /mnt/mini && \
		sudo mount /dev/$(6)p3 /mnt/sato && \
		sudo mount /dev/$(6)p4 /mnt/data && \
		df -hT | grep nbd && \
		sudo cp -v $(7)/build/tmp/deploy/images/qemuarm64/Image /mnt/boot/Image && \
		sudo cp -v $(7)/build/tmp/deploy/images/qemuarm64/Image-initramfs-qemuarm64.bin /mnt/boot/initramfs.bin && \
		sudo cp -v $(7)/build/tmp/deploy/images/qemuarm64/xen-qemuarm64.efi /mnt/boot/xen-qemuarm64.efi && \
		sudo tar xvf $(7)/build/tmp/deploy/images/qemuarm64/core-image-$(YOCTO_BUILD_TYPE)-qemuarm64.rootfs.tar.bz2 -C /mnt/$(YOCTO_BUILD_TYPE) && \
		sudo cp -v /mnt/boot/* /mnt/$(YOCTO_BUILD_TYPE)/boot/ && \
		sudo cp $(7)/{xen.cfg,virt-aarch64.dtb} /mnt/$(YOCTO_BUILD_TYPE)/ &&\
		sudo cp $(7)/init.sh /mnt/$(YOCTO_BUILD_TYPE)/init.sh && sudo chmod 755 /mnt/$(YOCTO_BUILD_TYPE)/init.sh && \
		sudo echo "/dev/vda2" | sudo tee -a /mnt/sato/etc/udev/mount.blacklist && \
		sudo umount /mnt/{boot,mini,sato,data}
	$(IQ)$(call nbd_dev_part_print,$(5),$(6))
	$(IQ)$(call nbd_dev_part_rmnode,$(6))
	$(IQ)$(call nbd_dev_disconnect,$(5))
endef

#		sudo grub-install --target=arm64-efi --recheck --efi-directory="/mnt/boot" --boot-directory="/mnt/$(YOCTO_BUILD_TYPE)/boot" && \
#		sudo cat $(7)/grub.cfg | sudo tee -a /mnt/boot/EFI/ubuntu/grub.cfg > /dev/null


YOCTO_PART_TABLE				:= \
	-n 1:0:+512M -c 1:"boot" -t 1:ef00 \
	-n 2:0:+2G -c 2:"min" -t 2:8300 \
	-n 3:0:+5G -c 3:"sato" -t 3:8300 \
	-n 4:0:+20G -c 4:"data" -t 4:8300

# image_prerun_install
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_prerun_install
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Pre-run Install",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Install Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install List",		$(5),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
	$(IQ)$(if $(call file_is_exist,$(3)/build/$(IMAGE_YOCTO_FILE_NAME)),$(call yocto_image_create,$(3)/build/$(IMAGE_YOCTO_FILE_NAME),qcow2,30G,$(YOCTO_PART_TABLE),/dev/nbd0,nbd0,$(3)))
endef


# image_custom_clean
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_clean
	$(IQ)cd $(3) && . ./oe-init-build-env && bitbake $(if $(1),$(1),$(YOCTO_BUILD_IMAGE) -c clean)
endef


# image_custom_distclean
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_distclean
	$(IQ)cd $(3) && . ./oe-init-build-env && bitbake $(if $(1),$(1),$(YOCTO_BUILD_IMAGE) -c distclean)
endef


# image_custom_action
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_action
	$(IQ)cd $(3) && $(if $(yocto_image_$(1)),$(call yocto_image_$(1),$(3)/build/$(IMAGE_YOCTO_FILE_NAME),qcow2,30G,$(YOCTO_PART_TABLE),/dev/nbd0,nbd0,$(3)),:)
endef


#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#





###############################################################################
# Build options

YOCTO_BUILD_TYPE			?= sato
YOCTO_BUILD_IMAGE			?= core-image-$(YOCTO_BUILD_TYPE)
YOCTO_BUILD_BRANCH			?= kyberlab/styhead/develop

YOCTO_IMAGE_FORMAT			?= qcow2
YOCTO_IMAGE_SIZE			?= 30G
YOCTO_IMAGE_DEVICE_FILE		?= /dev/nbd0
YOCTO_IMAGE_DEVICE_NAME		?= nbd0

YOCTO_IMAGE_PART_TABLE		:= \
	-n 1:0:+512M -c 1:"boot" -t 1:ef00 \
	-n 2:0:+2G -c 2:"min" -t 2:8300 \
	-n 3:0:+5G -c 3:"sato" -t 3:8300 \
	-n 4:0:+20G -c 4:"data" -t 4:8300



###############################################################################
# Emulator config and rules

$(eval $(call rule_inc,$(CONFIG_IMAGE_PATH)/$(IMAGE_BUILD_GOAL)/EmuConfig.mk))

$(eval $(call rule_inc,$(CONFIG_IMAGE_PATH)/$(IMAGE_BUILD_GOAL)/EmuImage.mk))



###############################################################################
# Image config options

# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Optional) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(REPO_URL_GIT_BASE)/poky.git
IMAGE_FETCH_REF				:= $(YOCTO_BUILD_BRANCH)

# (Optional) Patch options
IMAGE_PATCH_METHOD			:= file
IMAGE_PATCH_OPTS			:= 

# (Optional) Config options
#IMAGE_CONFIG_METHOD		:= 
IMAGE_CONFIG_OPTS			:= 

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
#IMAGE_INSTALL_METHOD		:= 
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= build/$(IMAGE_YOCTO_FILE_NAME):$(IMAGE_YOCTO_FILE_NAME) build/tmp/deploy/images/qemuarm64/xen-qemuarm64.efi:xen-qemuarm64.efi

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= 
IMAGE_PACKAGE_OPTS			:= build/$(IMAGE_YOCTO_FILE_NAME):$(IMAGE_YOCTO_FILE_NAME) build/tmp/deploy/images/qemuarm64/xen-qemuarm64.efi:xen-qemuarm64.efi
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


###############################################################################
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


# image_prerun_install
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_prerun_install
	$(IQ)$(if $(call file_is_exist,$(3)/build/$(IMAGE_YOCTO_FILE_NAME)),$(call yocto_image_create,$(3)/build/$(IMAGE_YOCTO_FILE_NAME),$(YOCTO_IMAGE_FORMAT),$(YOCTO_IMAGE_SIZE),$(YOCTO_IMAGE_PART_TABLE),$(YOCTO_IMAGE_DEVICE_FILE),$(YOCTO_IMAGE_DEVICE_NAME),$(3)))
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
	$(IQ)cd $(3) && $(if $(yocto_image_$(1)),$(call yocto_image_$(1),$(3)/build/$(IMAGE_YOCTO_FILE_NAME),$(YOCTO_IMAGE_FORMAT),$(YOCTO_IMAGE_SIZE),$(YOCTO_IMAGE_PART_TABLE),$(YOCTO_IMAGE_DEVICE_FILE),$(YOCTO_IMAGE_DEVICE_NAME),$(3)),:)
endef


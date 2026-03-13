#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




YOCTO_BUILD_IMAGE			?= core-image-sato
YOCTO_BUILD_BRANCH			?= kyberlab/styhead/develop


# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Required) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(REPO_URL_GIT_BASE)/poky.git
IMAGE_FETCH_REF				:= $(YOCTO_BUILD_BRANCH)

# (Optional) Patch options
#IMAGE_PATCH_METHOD			:= 
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


# image_prerun_build
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_build
	$(IQ)cd $(3) && . ./oe-init-build-env && bitbake $(if $(1),$(1),$(YOCTO_BUILD_IMAGE))
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


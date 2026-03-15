#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Required) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(REPO_URL_GIT_BASE)/xen.git
IMAGE_FETCH_REF				:= stable-4.18

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
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Post Fetch",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Fetch Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Fetch URL",		$(5),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Fetch REF",		$(6),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_config
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_config
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Config",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Config Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
endef


# image_prerun_build
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_build
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Build",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Build Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_clean
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_clean
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Clean",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Clean Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_distclean
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_distclean
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Distclean",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Distclean Options",$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
endef


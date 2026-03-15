#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Required) Fetch options
IMAGE_FETCH_METHOD			:= custom
IMAGE_FETCH_OPTS			:= aa
IMAGE_FETCH_URL				:= 
IMAGE_FETCH_REF				:= 

# (Optional) Patch options
IMAGE_PATCH_METHOD			:= custom
IMAGE_PATCH_OPTS			:= bb

# (Required) Config options
#IMAGE_CONFIG_METHOD		:= 
IMAGE_CONFIG_OPTS			:= cc

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= dd

# (Optional) Install options
IMAGE_INSTALL_METHOD		:= custom
IMAGE_INSTALL_OPTS			:= ee
IMAGE_INSTALL_LIST			:= 

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= 
IMAGE_PACKAGE_OPTS			:= ff
IMAGE_PACKAGE_LIST			:= 

# (Optional) Clean options
#IMAGE_CLEAN_METHOD			:= 
IMAGE_CLEAN_OPTS			:= gg

# (Optional) Distclean options
#IMAGE_DISTCLEAN_METHOD		:= 
IMAGE_DISTCLEAN_OPTS		:= hh


# (Optional) Extra step

# image_custom_fetch
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_custom_fetch
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Fetch",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Fetch Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Fetch URL",		$(5),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Fetch REF",		$(6),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
	$(Q)mkdir -pv $(3)
endef


# image_custom_patch
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_patch
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Patch",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Patch Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Patch Files",		$(wildcard $(2)/Patches/*.patch),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_config
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_config
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Config",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Config Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_prerun_build
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_build
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Build",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Build Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_install
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_custom_install
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Install",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Install Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install List",		$(5),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_package
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_custom_package
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Package",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Package Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Package List",		$(5),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_clean
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_clean
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Clean",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Clean Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_custom_distclean
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_distclean
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Distclean",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Distclean Options",$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


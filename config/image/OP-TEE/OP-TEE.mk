#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# $ make op-tee_action
# QEMU 5.1.0 monitor - type 'help' for more information
# (qemu) c
# Normal World $ xtest



# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Optional) Fetch options
IMAGE_FETCH_METHOD			:= repo
IMAGE_FETCH_OPTS			:= qemu_v8.xml
IMAGE_FETCH_URL				:= https://github.com/OP-TEE/manifest.git
IMAGE_FETCH_REF				:= master

# (Optional) Patch options
#IMAGE_PATCH_METHOD			:= 
IMAGE_PATCH_OPTS			:= 

# (Optional) Config options
#IMAGE_CONFIG_METHOD		:= 
IMAGE_CONFIG_OPTS			:= 

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
#IMAGE_INSTALL_METHOD		:= custom
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
IMAGE_ACTION_METHOD			:= custom
IMAGE_ACTION_OPTS			:= 


# (Optional) Extra step

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
	$(IQ)cd $(3)/build && make -j$$(nproc) toolchains && make -j$$(nproc) FORCE_UNSAFE_CONFIGURE=1 GDBSERVER=y
endef


# image_custom_install
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_custom_install
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Install",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Install Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install List",		$(5),$($(BG_PURPLE)))
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


# image_custom_action
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_action
	$(IQ)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Action",$(BG_YELLOW))
	$(IQ)$(call xprint_value,	"Action Options",	$(1),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(IQ)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(IQ)$(call xprint_line,$(BG_YELLOW))
	$(IQ)cd $(3)/build && make run QEMU_USERNET_ENABLE=y FORCE_UNSAFE_CONFIGURE=1
endef



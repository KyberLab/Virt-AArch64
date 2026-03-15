#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# (Required) Build type
IMAGE_BUILD_TYPE			:= Skip


# (Required) Fetch options
IMAGE_FETCH_METHOD			:= git
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(IMAGE_EMU_URL)
IMAGE_FETCH_REF				:= $(IMAGE_EMU_REF)

# (Optional) Patch options
#IMAGE_PATCH_METHOD			:= skip
IMAGE_PATCH_OPTS			:= bb

# (Required) Config options
#IMAGE_CONFIG_METHOD			:= skip
IMAGE_CONFIG_OPTS			:= cc

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
#IMAGE_INSTALL_METHOD		:= skip
IMAGE_INSTALL_OPTS			:= eee
IMAGE_INSTALL_LIST			:= abc

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= skip
IMAGE_PACKAGE_OPTS			:= ff
IMAGE_PACKAGE_LIST			:= xyz

# (Optional) Clean options
#IMAGE_CLEAN_METHOD			:= 
IMAGE_CLEAN_OPTS			:= gg

# (Optional) Remove options
IMAGE_REMOVE_METHOD			:= git
#IMAGE_REMOVE_OPTS			:= gg

# (Optional) Distclean options
#IMAGE_DISTCLEAN_METHOD		:= skip
IMAGE_DISTCLEAN_OPTS		:= hh

# (Optional) Info options
IMAGE_INFO_METHOD			:= dump
IMAGE_INFO_OPTS				:= 

# (Optional) Status options
IMAGE_STATUS_METHOD			:= dump
IMAGE_STATUS_OPTS			:= 

# (Optional) Action options
IMAGE_ACTION_METHOD			:= custom
IMAGE_ACTION_OPTS			:= 

# (Optional) Summary options
IMAGE_SUMMARY_METHOD		:= dump
IMAGE_SUMMARY_OPTS			:= 


# (Optional) Extra step

# image_prerun_build
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_build
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Build",$(HB_YELLOW))
	$(Q)$(call xprint_value,	"Build Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
endef


# image_custom_clean
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_clean
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Clean",$(HB_YELLOW))
	$(Q)$(call xprint_value,	"Clean Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
endef


# image_custom_action
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_action
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Action",$(HB_YELLOW))
	$(Q)$(call xprint_value,	"Action Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)cd $(3) && $(IMAGE_EXPORT_ENV) $(MAKE) run $(1) $(call make_cmd_vars)
endef


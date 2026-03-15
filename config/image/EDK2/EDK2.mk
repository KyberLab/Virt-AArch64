#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




$(eval $(call rule_inc,$(CONFIG_IMAGE_PATH)/$(IMAGE_BUILD_GOAL)/EmuConfig.mk))

# (Required) Build type
IMAGE_BUILD_TYPE			:= Custom

# (Required) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(REPO_URL_GIT_BASE)/edk2.git
IMAGE_FETCH_REF				:= edk2-stable202602

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
IMAGE_INSTALL_LIST			:= Build/ArmVirtQemu-AArch64/RELEASE_GCC5/FV/QEMU_EFI.fd:$(IMAGE_EDK2_UEFI_CODE)
IMAGE_INSTALL_LIST			+= Build/ArmVirtQemu-AArch64/RELEASE_GCC5/FV/QEMU_VARS.fd:$(IMAGE_EDK2_UEFI_VARS)

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= 
IMAGE_PACKAGE_OPTS			:= 
IMAGE_PACKAGE_LIST			:= $(IMAGE_EDK2_UEFI_CODE) $(IMAGE_EDK2_UEFI_VARS) $(IMAGE_EDK2_UEFI_PFLASH0) $(IMAGE_EDK2_UEFI_PFLASH1)

# (Optional) Clean options
#IMAGE_CLEAN_METHOD			:= 
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
#IMAGE_DISTCLEAN_METHOD		:= 
IMAGE_DISTCLEAN_OPTS		:= 


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


# image_custom_build
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
	$(IQ)cd $(3) && \
		source ./edksetup.sh && \
		export CROSS_COMPILE=aarch64-none-linux-gnu- && \
		export GCC5_AARCH64_PREFIX=aarch64-none-linux-gnu- && \
		make -C BaseTools && \
		build -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc -b RELEASE
endef


# image_postrun_install
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_postrun_install
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Post-run Install",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Install Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install List",		$(5),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
	$(Q)rm -fv $(4)/$(IMAGE_EDK2_UEFI_PFLASH0); dd if=/dev/zero bs=1M count=64 of=$(4)/$(IMAGE_EDK2_UEFI_PFLASH0)
	$(Q)rm -fv $(4)/$(IMAGE_EDK2_UEFI_PFLASH1); dd if=/dev/zero bs=1M count=64 of=$(4)/$(IMAGE_EDK2_UEFI_PFLASH1)
	$(Q)dd if=$(4)/$(IMAGE_EDK2_UEFI_CODE) bs=1M of=$(4)/$(IMAGE_EDK2_UEFI_PFLASH0) conv=notrunc
	$(Q)dd if=$(4)/$(IMAGE_EDK2_UEFI_VARS) bs=1M of=$(4)/$(IMAGE_EDK2_UEFI_PFLASH1) conv=notrunc
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


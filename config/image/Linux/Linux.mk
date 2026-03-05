#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# (Required) Build type
IMAGE_BUILD_TYPE			:= Linux


# (Required) Fetch options
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= $(IMAGE_LINUX_URL)
IMAGE_FETCH_REF				:= $(IMAGE_LINUX_REF)


# (Optional) Patch options
IMAGE_PATCH_OPTS			:= 

# (Required) Config options
IMAGE_CONFIG_OPTS			:= kyberlab_defconfig


# (Optional) Build options
IMAGE_BUILD_OPTS			:= 

# (Optional) Install options
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= build/arch/arm64/boot/Image:Linux.bin output:$(IMAGE_BUILD_GOAL)

# (Optional) Package options
IMAGE_PACKAGE_OPTS			:= 
IMAGE_PACKAGE_LIST			:= Linux.bin $(IMAGE_BUILD_GOAL)

# (Optional) Clean options
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
IMAGE_DISTCLEAN_OPTS		:= 



###############################################################################
# Image Build Variables (Optional)

IMAGE_EXPORT_ENV			+= ARCH=arm64
IMAGE_EXPORT_ENV			+= CROSS_COMPILE=aarch64-none-elf-



# image_postrun_config
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
#define image_postrun_config
#	$(Q)$(call xprint_title,	"Image Post-Run Config",$(BG_YELLOW))
#	$(Q)$(call xprint_value,	"Config Options",	$(1),$(BG_PURPLE))
#	$(Q)$(call xprint_value,	"Config Path",		$(2),$(BG_PURPLE))
#	$(Q)$(call xprint_value,	"Build Path",		$(3),$(BG_PURPLE))
#	$(Q)$(call xprint_value,	"Install Path",		$(4),$(BG_PURPLE))
#	$(Q)$(call xprint_filled,$(BG_PURPLE))
#	$(Q)cd $(3) && sed -i 's/.*CONFIG_BLK_DEV_RAM[ =].*/CONFIG_BLK_DEV_RAM=y/g' build/.config
#endef


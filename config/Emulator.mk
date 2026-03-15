#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#
ifneq ($(shell echo $${BENCH_WORK_PATH}),)
ifeq ($(BUILD_PLATFORM),qemu)


ifneq ($(call file_is_exist,$(CONFIG_IMAGE_PATH)),)
$(error "$(CONFIG_IMAGE_PATH) not exist")
endif

EMU_IMAGE_LIST			:= $(shell ls $(CONFIG_IMAGE_PATH)/*/EmuConfig.mk 2>/dev/null | awk -F "/" '{print $$(NF-1)}' | sort -u)

EMU_TARGET_LIST			:= $(foreach image,$(EMU_IMAGE_LIST),emu_$(image))
EMU_TARGET_LIST			+= $(foreach image,$(EMU_IMAGE_LIST),emu_$(call string_to_lower,$(image)))
EMU_TARGET_LIST			+= $(foreach image,$(EMU_IMAGE_LIST),emu_$(call string_to_upper,$(image)))
EMU_TARGET_LIST			:= $(sort $(EMU_TARGET_LIST))
#$(warning EMU_TARGET_LIST=$(EMU_TARGET_LIST))

define emu_boot_image
$(shell name=`find $(CONFIG_IMAGE_PATH) -maxdepth 1 -type d -iname $(patsubst emu_%,%,$(1)) -printf "%f"` && [ -z $$name ] && echo $(QEMU_BOOT_IMAGE) || echo $$name)
endef

.PHONY : emu $(EMU_TARGET_LIST)

emu $(EMU_TARGET_LIST) : 
	$(Q)cd $(WORKSPACE_ROOT_PATH)/image && $(MAKE) kyberemu_action $(call build_export_env) $(EMU_RUN_ARGS) QEMU_BOOT_IMAGE=$(call emu_boot_image,$@)




endif # ($(BUILD_PLATFORM),qemu)
endif # ($(shell echo $${BENCH_WORK_PATH}),)

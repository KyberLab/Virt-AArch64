#                                 KyberVirt
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




ifneq ($(shell echo $${BENCH_WORK_PATH}),)
ifeq ($(BUILD_PLATFORM),qemu)

.PHONY : emu

emu :
	$(Q)cd $(WORKSPACE_ROOT_PATH)/image && $(MAKE) kyberemu_action $(call build_export_env) $(EMU_RUN_ARGS)

endif # ($(BUILD_PLATFORM),qemu)
endif # ($(shell echo $${BENCH_WORK_PATH}),)



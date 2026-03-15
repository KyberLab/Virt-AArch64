#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Build Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/config/Default.mk))

#QEMU_GRAPHIC_TYPE			?= none
#QEMU_GRAPHIC_ARGS			?= -nographic

QEMU_BOOT_IMAGE				?= BuildRoot

EMU_RUN_ARGS				:= \
	$(if $(QEMU_GRAPHIC_TYPE),QEMU_GRAPHIC_TYPE=$(QEMU_GRAPHIC_TYPE)) \
	$(if $(QEMU_GRAPHIC_ARGS),QEMU_GRAPHIC_ARGS=$(QEMU_GRAPHIC_ARGS)) \
	$(if $(QEMU_RUN_EXTRAS),QEMU_RUN_EXTRAS=$(QEMU_RUN_EXTRAS))



###############################################################################
# Network Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/config/Network.mk))



###############################################################################
# Repo Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/config/Repo.mk))


#                                 KyberVirt
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Build Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/config/Default.mk))



###############################################################################
# Network Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/config/Network.mk))



###############################################################################
# Repo Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/config/Repo.mk))


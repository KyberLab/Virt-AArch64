#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Default Macros

# file_is_exist
# $(1) file path
# return empty if exist.
ifeq ($(origin file_is_exist),undefined)
define file_is_exist
$(shell ls $(1) > /dev/null 2>&1;echo $$? | grep -v 0)
endef
endif

# rule_inc
# $(1) rule file path
ifeq ($(origin rule_inc),undefined)
define rule_inc
$(if $(call file_is_exist,$(1)),$(error Rule File "$(1)" Not Exist !!!),include $(1))
endef
endif

# is_in_docker
# return : empty if in docker
ifeq ($(origin is_in_docker),undefined)
define is_in_docker
$(shell echo `[ ! -f /.dockerenv ]` $$? | grep -v 1)
endef
endif

# cur_dir
# return : current directory path
ifeq ($(origin cur_dir),undefined)
define cur_dir
$(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
endef
endif



###############################################################################
# Path Check

ifeq ($(origin WORKSPACE_ROOT_PATH),undefined)
#$(warning "WORKSPACE_ROOT_PATH has not been defined.")
WORKSPACE_ROOT_PATH			:= $(call cur_dir)
#$(warning Define WORKSPACE_ROOT_PATH = $(WORKSPACE_ROOT_PATH))
endif



###############################################################################
# Image Build Rules

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/image/Main.mk))


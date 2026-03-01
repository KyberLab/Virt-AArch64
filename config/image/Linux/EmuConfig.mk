#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




IMAGE_BOOT_BIN				:= $(OUTPUT_ROOT_PATH)/Linux.bin

IMAGE_RUN_ARGS				+= \
	-kernel $(IMAGE_BOOT_BIN)


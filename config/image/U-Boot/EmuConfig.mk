#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




IMAGE_BOOT_BIN				?= $(OUTPUT_ROOT_PATH)/U-Boot.img
IMAGE_UBOOT_BOOT_BIN		?= $(OUTPUT_ROOT_PATH)/Linux.bin


IMAGE_PRE_RUN				+= \
	$(call xprint_title,	"U-Boot Shell") && \
	$(call xprint_notice,		"Type in \"booti 0x40200000 - 0x40000000\"")


IMAGE_RUN_ARGS				+= \
	-drive if=pflash,format=raw,readonly=on,index=0,file=$(IMAGE_BOOT_BIN) \
	-device loader,file=$(IMAGE_UBOOT_BOOT_BIN),addr=0x40200000


#                                 KyberLab
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# qemu_image_create
# $(1) qemu image file path
# $(2) image format
# $(3) image size
define qemu_image_create
	$(IQ)qemu-img create -f $(2) $(1) $(3)
	$(IQ)qemu-img info $(1)
endef


# yocto_image_mount
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_mount
	$(IQ)$(call nbd_dev_init,$(5))
	$(IQ)$(call nbd_dev_disconnect,$(5))
	$(IQ)$(call nbd_dev_connect,$(5),$(1))
	$(IQ)$(call nbd_dev_part_mknode,$(6))
	$(IQ)sudo mkdir -pv /mnt/{boot,mini,sato,data} && \
		sudo mount /dev/$(6)p1 /mnt/boot && \
		sudo mount /dev/$(6)p2 /mnt/mini && \
		sudo mount /dev/$(6)p3 /mnt/sato && \
		sudo mount /dev/$(6)p4 /mnt/data && \
		df -hT | grep nbd
endef


# yocto_image_umount
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_umount
	$(IQ)$(call nbd_dev_init,$(5))
	$(IQ)$(call nbd_dev_part_mknode,$(6))
	$(IQ)$(call nbd_dev_part_print,$(5),$(6))
	$(IQ)sudo umount /mnt/{boot,mini,sato,data}
	$(IQ)$(call nbd_dev_part_rmnode,$(6))
	$(IQ)$(call nbd_dev_disconnect,$(5))
endef


# yocto_image_create_helper
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_create_helper
	$(IQ)sudo tar xvf $(7)/build/tmp/deploy/images/qemuarm64/core-image-$(YOCTO_BUILD_TYPE)-qemuarm64.rootfs.tar.bz2 -C /mnt/$(YOCTO_BUILD_TYPE)
	$(IQ)sudo cp -v $(7)/build/tmp/deploy/images/qemuarm64/Image /mnt/boot/Image
	$(IQ)sudo cp -v $(7)/build/tmp/deploy/images/qemuarm64/Image-initramfs-qemuarm64.bin /mnt/boot/initramfs.bin
	$(IQ)sudo cp -v $(7)/build/tmp/deploy/images/qemuarm64/xen-qemuarm64.efi /mnt/boot/xen-qemuarm64.efi
	$(IQ)sudo cp -v $(7)/{grubaa64.efi,grub.cfg,xen.cfg,virt-aarch64.dtb} /mnt/boot/
	$(IQ)sudo cp -v /mnt/boot/* /mnt/$(YOCTO_BUILD_TYPE)/boot/
	$(IQ)sudo install -v -m 755 $(7)/init.sh /mnt/$(YOCTO_BUILD_TYPE)/init.sh
	$(IQ)sudo mkdir -v /mnt/$(YOCTO_BUILD_TYPE)/etc/init.d/
	$(IQ)sudo install -v -m 755 $(7)/rcS /mnt/$(YOCTO_BUILD_TYPE)/etc/init.d/rcS
	$(IQ)sudo install -v -m 755 $(7)/rcK /mnt/$(YOCTO_BUILD_TYPE)/etc/init.d/rcK
	$(IQ)sudo install -v -m 644 $(7)/inittab /mnt/$(YOCTO_BUILD_TYPE)/etc/inittab
endef


# yocto_image_create
# $(1) qemu image file path
# $(2) qemu image format
# $(3) qemu image size
# $(4) qemu image partition table
# $(5) nbd device file path
# $(6) nbd device file name
# $(7) build path
define yocto_image_create
	$(IQ)$(call nbd_dev_init,$(5))
	$(IQ)$(call nbd_dev_disconnect,$(5))
	$(IQ)$(call qemu_image_create,$(1),$(2),$(3))
	$(IQ)$(call nbd_dev_connect,$(5),$(1))
	$(IQ)$(call nbd_dev_part,$(5),$(4))
	$(IQ)$(call nbd_dev_part_mknode,$(6))
	$(IQ)$(call nbd_dev_format,$(5),$(6),1,vfat,-F32)
	$(IQ)$(call nbd_dev_format,$(5),$(6),2,ext4)
	$(IQ)$(call nbd_dev_format,$(5),$(6),3,ext4)
	$(IQ)$(call nbd_dev_format,$(5),$(6),4,ext4)
	$(IQ)sudo mkdir -pv /mnt/{boot,mini,sato,data} && \
		sudo mount /dev/$(6)p1 /mnt/boot && \
		sudo mount /dev/$(6)p2 /mnt/mini && \
		sudo mount /dev/$(6)p3 /mnt/sato && \
		sudo mount /dev/$(6)p4 /mnt/data
	$(IQ)$(call yocto_image_create_helper,$(1),$(2),$(3),$(4),$(5),$(6),$(7))
	$(IQ)df -hT | grep nbd && sudo umount /mnt/{boot,mini,sato,data}
	$(IQ)$(call nbd_dev_part_print,$(5),$(6))
	$(IQ)$(call nbd_dev_part_rmnode,$(6))
	$(IQ)$(call nbd_dev_disconnect,$(5))
endef

#		sudo echo "/dev/vda2" | sudo tee -a /mnt/sato/etc/udev/mount.blacklist && \
#		sudo grub-install --target=arm64-efi --recheck --efi-directory="/mnt/boot" --boot-directory="/mnt/$(YOCTO_BUILD_TYPE)/boot" && \
#		sudo cat $(7)/grub.cfg | sudo tee -a /mnt/boot/EFI/ubuntu/grub.cfg > /dev/null



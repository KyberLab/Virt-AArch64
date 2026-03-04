#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# (Required) Build type
IMAGE_BUILD_TYPE			:= AutoMake

# (Required) Fetch options
#IMAGE_FETCH_METHOD			:= 
IMAGE_FETCH_OPTS			:= 
IMAGE_FETCH_URL				:= 
IMAGE_FETCH_REF				:= 

# (Optional) Patch options
#IMAGE_PATCH_METHOD			:= 
IMAGE_PATCH_OPTS			:= 

# (Required) Config options
#IMAGE_CONFIG_METHOD		:= 
IMAGE_CONFIG_OPTS			:= \
		--enable-debug \
		--enable-kvm \
		--enable-fdt \
		--enable-vnc \
		--enable-vnc-jpeg \
		--enable-sdl \
		--enable-sdl-image \
		--enable-fuse \
		--enable-spice \
		--enable-bzip2 \
		--enable-gtk \
		--enable-rdma \
		--enable-linux-aio \
		--enable-rbd \
		--enable-seccomp \
		--enable-slirp \
		--enable-xen \
		--enable-libpmem \
		--enable-capstone \
		--enable-cap-ng \
		--enable-opengl \
		--enable-virglrenderer \
		--enable-vfio-user-server \
		--enable-vhost-kernel \
		--enable-vhost-user \
		--enable-vhost-net \
		--enable-vhost-user-blk-server \
		--enable-vduse-blk-export \
		--enable-vhost-vdpa \
		--enable-virtfs \
		--enable-vnc \
		--enable-vnc-jpeg \
		--enable-libusb \
		--enable-tools \
		--enable-qed \
		--enable-attr \
		--enable-curses \
		--enable-virtfs \
		--enable-guest-agent \
		--enable-debug-info \
		--target-list=aarch64-softmmu,arm-softmmu,x86_64-softmmu,i386-softmmu,riscv64-softmmu,riscv32-softmmu

# (Optional) Build options
#IMAGE_BUILD_METHOD			:= 
IMAGE_BUILD_OPTS			:= 
# -j$(shell nproc)

# (Optional) Install options
#IMAGE_INSTALL_METHOD		:= 
IMAGE_INSTALL_OPTS			:= 
IMAGE_INSTALL_LIST			:= 

# (Optional) Package options
#IMAGE_PACKAGE_METHOD		:= 
IMAGE_PACKAGE_OPTS			:= 
IMAGE_PACKAGE_LIST			:= 

# (Optional) Clean options
#IMAGE_CLEAN_METHOD			:= 
IMAGE_CLEAN_OPTS			:= 

# (Optional) Distclean options
#IMAGE_DISTCLEAN_METHOD		:= 
IMAGE_DISTCLEAN_OPTS		:= 


# (Optional) Action options
IMAGE_ACTION_METHOD			:= custom
IMAGE_ACTION_OPTS			:= 


# (Optional) Extra step


# image_custom_action
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_custom_action
	$(Q)$(4)/$(IMAGE_BUILD_GOAL)/bin/qemu-system-aarch64 $(if $(1),$(1),--version)
endef


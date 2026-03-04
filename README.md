# KyberLab Virt-AArch64

[中文版本](README_zh.md) | English Version

## Project Overview

KyberLab Virt-AArch64 is a virtual development platform for AArch64 architecture:
* Simplify Makefile rule writing through KyberRules' Makefile macros;
* Build containerized development environments through KyberBench to ensure development environment consistency;
* Solidify image building methods and steps through KyberImage's image building methods;
* Simplify emulator configuration and execution through KyberEmu's Qemu run scripts.

By implementing automated building and running of various system images, it achieves DevOps for basic software development, enabling one-to-one mapping from source code and configuration to system images, simplifying configuration management for basic software development, and improving development efficiency and quality.

In the AI era, software development methods such as Vibe Coding and Spec Coding are becoming increasingly popular. However, in the basic software development field, due to the variability of development and runtime environments and the complexity of build and deployment steps, development efficiency is low. It is also not conducive to automated coding and testing through AI. To address this, KyberLab simplifies and automates the setup of basic software development environments, building, deployment, and running of various system images, making it easier for AI and engineers to develop basic software.

## Key Features

### 1. Virtual Workbench Environment
- Provide container-based virtual development environments;
- Use Jinja2 to enhance the programmability of Dockerfiles;
- Use tools and methods like Dockpin to solidify software package versions.

### 2. System Image Building
- Support building and customizing various operating system images, easily adapting to build methods like BuildRoot and Yocto;
- Provide flexible build configurations and automated workflows, allowing flexible extension of build methods;
- Pre-integrate multiple build methods: Linux, BusyBox, BuildRoot, etc.

## Quick Start

### 1. Environment Preparation

Ensure the following dependencies are installed:
- Git;
- Make;
- Docker.

### 2. Clone Repository

```bash
git clone https://github.com/KyberLab/Virt-AArch64.git
cd Virt-AArch64
git submodule update --init --recursive
```

### 3. Build Virtual Workbench Image

```bash
# Build Dockpin virtual workbench image, supported container images are directory names under bench/image/Dockpin/Dockerfile directory
make build_dockpin

# Build Virt-AArch64 virtual workbench image
make build_virt-aarch64

# Start Virt-AArch64 virtual workbench environment and enter interactive shell
make run_virt-aarch64
```

### 4. Build System Image

```bash
# Build default image (will automatically enter container and execute in build directory by default)
make build

# Install default image (specified by IMAGE_BUILD_LIST variable)
make install

# Install BusyBox (default installation to output directory), supported system images are directory names under config/image directory
make busybox_install
```

### 5. Run System Image

```bash
# Run default image
make run

# Run BuildRoot image
make run QEMU_BOOT_IMAGE=BuildRoot
```

## Directory Structure

```
KyberLab Virt-AArch64/
├── bench/           # Virtual workbench environment
│   ├── image/       # Workbench image configurations
│   ├── rules/       # Build rules and utilities
│   └── *.mk         # Workbench build and run scripts
├── config/          # Configuration directory
│   └── image/       # Build goal configurations
│       ├── BuildRoot/  # BuildRoot configuration
│       ├── BusyBox/    # BusyBox configuration
│       ├── KyberEmu/   # Emulator configuration
│       ├── Linux/      # Linux configuration
│       ├── U-Boot/     # U-Boot configuration
│       └── Ubuntu/     # Ubuntu configuration
├── image/           # Image building directory
│   ├── goal/        # Build goals
│   ├── method/      # Build method configurations
│   ├── scripts/     # Build scripts
│   └── type/        # Image type configurations
├── download/        # Download directory (ignored)
├── build/           # Build output directory (ignored)
├── output/          # Final output directory (ignored)
├── Makefile         # Main build script
├── WorkSpace.mk     # Workspace configuration
├── README.md        # English project documentation
└── README_zh.md     # Chinese project documentation
```

## Basic Concepts

- **Virtual Workbench Environment (Bench)**: Provides container-based virtual development environments for developing and testing basic software;
- **System Image Building (Image)**: Supports building and customizing various operating system images, easily adapting to build methods like Buildroot and Yocto;
- **Build Rules and Tools (Rules)**: Provides flexible build configurations and automated workflows, allowing flexible extension of build methods;
- **Pre-integrated Build Methods (Methods)**: Pre-integrates multiple build methods such as Linux, BusyBox, BuildRoot, etc.

### Build Goal

Build goals are located in the `config/image/` directory and are instances of system image building. Each build goal must specify a build type (Type) and can override the build methods within it.

### Build Type

Build types define the build methods and steps for build goals (Goal). Currently supported build types include:

- **U-Boot**: Build U-Boot bootloader;
- **Linux**: Build Linux kernel and kernel modules;
- **BusyBox**: Build BusyBox system;
- **BuildRoot**: Build BuildRoot system;
- **Ubuntu**: Build Ubuntu system.

### Build Phases

Build phases are the basic steps that each build goal (Goal) needs to execute during the build process, mainly including:
- **Fetch**: Obtain build resources;
- **Patch**: Apply patches or copy pre-compiled files;
- **Config**: Configure build goals;
- **Build**: Formal build;
- **Install**: Install to specified directory;
- **Package**: Package target files, generally as tar.xz compressed packages or Bin installation packages;
- **Clean**: Basic cleanup, generally only cleans build intermediate files;
- **Distclean**: Thorough cleanup, clears configuration and installed files;
- **Remove**: Delete build files;
- **Info**: View build information;
- **Status**: View build status;
- **Action**: Execute image custom operations;
- **Summary**: View image summary information.

### Build Methods

The specific implementation methods for each build type (Type) and build phase (Phase), mainly include:

- **Dump**: Only print Phase information;
- **Skip**: Skip Phase, do not execute any operations;
- **Scons**: Support Scons-based build methods;
- **BuildRoot**: Support BuildRoot-based build methods;
- **Custom**: Support custom build methods;
- **Linux**: Support Linux-based build methods;
- **Git**: Support Git-based build methods, mainly for Patch phase;
- **Patch**: Support applying patches or copying pre-compiled files, mainly for Patch phase;
- **Copy**: Support copying files to specified directories, mainly for Patch and Install phases;
- **Install**: Support installing files to specified directories, mainly for Install phase;
- **Tar**: Support packaging target files, mainly for Package phase.

## Configuration Instructions

### Configuration Options

The project supports multiple image builds, located in the `config/image/` directory:

- **BuildRoot**: BuildRoot configuration;
- **BusyBox**: BusyBox configuration;
- **KyberEmu**: Emulator configuration;
- **Linux**: Linux configuration;
- **U-Boot**: U-Boot configuration;
- **Ubuntu**: Ubuntu system configuration.

### Build Methods

Supports multiple build methods located in the `image/method/` directory, and multiple build types located in the `image/type/` directory.

For more details, see the [image documentation](image/README.md).

## Virtual Workbench Environment

The virtual workbench environment is located in the `bench/` directory, providing:

- Virtual environment building and running framework;
- Workbench image configurations;
- Build rules and tools;
- Support for different architectures.

For more details, see the [bench documentation](bench/README.md).

## Contribution Guide

1. Fork the project repository;
2. Create a feature branch;
3. Commit your changes;
4. Submit a Pull Request.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

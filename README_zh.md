# KyberLab Virt-AArch64

[English Version](README.md) | 中文版本

## 项目简介

KyberLab Virt-AArch64 是一个 AArch64 架构的虚拟开发平台：
* 通过 KyberRules 提供的Makefile宏，简化Makefile规则的编写；
* 通过 KyberBench 构建基于容器化的开发环境，保证开发环境的一致性；
* 通过 KyberImage 提供的镜像构建方法，固化镜像构建的方法和步骤；
* 通过 KyberEmu 提供的Qemu运行脚本，简化模拟器的配置和运行。

通过实现多种系统镜像的自动化构建和运行，实现基础软件开发的DevOps，做到从源码和配置到系统镜像的一一映射，简化基础软件开发的配置管理，提高开发效率和质量。

在AI时代，通过 Vibe Coding 和 Spec Coding 进行软件开发的方法已经越来越流行。然而，在基础软件开发领域，由于开发和运行环境多变，构建和部署步骤繁杂，导致开发效率低下。同时也不利于通过AI来自动化的编码和测试，为此，KyberLab 通过简化和自动化基础软件的开发环境的搭建、多种系统镜像的构建、部署和运行，从而使得 AI 和工程师更容易的开发基础软件。


## 主要功能

### 1. 虚拟工作环境
- 提供基于容器的虚拟开发环境；
- 使用 Jinja2 增强 Dockerfile 的可编程性；
- 使用 Dockpin 等工具和方法固化软件包版本。

### 2. 系统镜像构建
- 支持多种操作系统镜像的构建和定制，轻松适配 BuildRoot、Yocto 等构建方法；
- 提供灵活的构建配置和自动化流程，可灵活扩展构建方法；
- 预集成多种构建方法：Linux、BusyBox、BuildRoot等。


## 快速开始

### 1. 环境准备

确保系统已安装以下依赖：
- Git；
- Make；
- Docker。


### 2. 克隆仓库

```bash
git clone https://github.com/KyberLab/Virt-AArch64.git
cd Virt-AArch64
git submodule update --init --recursive
```

### 3. 构建虚拟工作台镜像

```bash
# 构建Dockpin虚拟工作台镜像，支持的容器镜像为 bench/image/Dockpin/Dockerfile 目录下的目录名
make build_dockpin

# 构建Virt-AArch64虚拟工作台镜像
make build_virt-aarch64

# 启动Virt-AArch64虚拟工作台环境，并进入交互式Shell
make run_virt-aarch64
```

### 4. 构建系统镜像

```bash
# 构建默认镜像(默认会自动进入容器中执行，并在build目录中执行构建)
make build

# 安装默认（由 IMAGE_BUILD_LIST 变量指定）镜像
make install

# 安装BusyBox(默认安装到output目录)，支持的系统镜像为 config/image 目录下的目录名
make busybox_install
```

### 5. 运行系统镜像

```bash
# 运行默认镜像
make run

# 运行BuildRoot镜像
make run QEMU_BOOT_IMAGE=BuildRoot
```

## 目录结构

```
KyberLab Virt-AArch64/
├── bench/           # 虚拟工作台环境
│   ├── image/       # 工作台镜像配置
│   ├── rules/       # 构建规则和工具
│   └── *.mk         # 工作台构建和运行脚本
├── config/          # 配置目录
│   └── image/       # 构建目标（Goal）配置
│       ├── BuildRoot/  # BuildRoot 配置
│       ├── BusyBox/    # BusyBox 配置
│       ├── KyberEmu/   # 模拟器配置
│       ├── Linux/      # Linux 配置
│       ├── U-Boot/     # U-Boot 配置
│       └── Ubuntu/     # Ubuntu 配置
├── image/           # 镜像构建目录
│   ├── goal/        # 构建目标
│   ├── method/      # 构建方法（Method）配置
│   ├── scripts/     # 构建脚本
│   └── type/        # 镜像类型（Type）配置
├── download/        # 下载目录（忽略）
├── build/           # 构建输出目录（忽略）
├── output/          # 最终输出目录（忽略）
├── Makefile         # 主构建脚本
├── WorkSpace.mk     # 工作空间配置
├── README.md        # 英文项目说明
└── README_zh.md     # 中文项目说明
```

## 基本概念

- 虚拟工作台环境（Bench）：提供基于容器的虚拟开发环境，用于开发和测试基础软件；
- 系统镜像构建（Image）：支持多种操作系统镜像的构建和定制，轻松适配 Buildroot、Yocto 等构建方法；
- 构建规则和工具（Rules）：提供灵活的构建配置和自动化流程，可灵活扩展构建方法；
- 预集成构建方法（Methods）：预集成多种构建方法，如 Linux、BusyBox、BuildRoot 等。

### 构建目标

构建目标（Goal）位于`config/image/`目录下，是系统镜像构建的实例，每个构建目标必须指定一个构建类型（Type），并可对其中的构建方法进行重载。

### 构建类型

构建类型（Type）定义构建目标（Goal）的构建方法和步骤，目前支持的构建类型有：

- U-Boot，构建U-Boot引导加载器；
- Linux，构建Linux内核和内核模块；
- BusyBox，构建BusyBox系统；
- BuildRoot，构建BuildRoot系统；
- Ubuntu，构建Ubuntu系统。


### 构建阶段

构建阶段（Phase）是每个构建目标（Goal）在构建过程中需要执行的基本步骤，主要有：
- Fetch，获取构建资源；
- Patch，打补丁或复制预编译文件；
- Config，配置构建目标；
- Build，正式构建；
- Install，安装到指定目录；
- Package，打包目标文件，一般为tar.xz压缩包或Bin安装包；
- Clean，基本清理，一般只会清理构建中间文件；
- Distclean，彻底清理，会清除配置和已安装文件;
- Remove，删除构建文件；
- Info，查看构建信息；
- Status，查看构建状态；
- Action，执行镜像自定义的操作；
- Summary，查看镜像概要信息。

### 构建方法（Method）

每个构建类型（Type）和构建阶段（Phase）的具体实现方法,主要有：

- Dump，仅打印 Phase 信息；
- Skip，跳过 Phase ，不执行任何操作；
- Scons，支持基于 Scons 的构建方法；
- BuildRoot，支持基于 BuildRoot 的构建方法；
- Custom，支持自定义构建方法；
- Linux，支持基于 Linux 的构建方法；
- Git，支持基于 Git 的构建方法，主要是 Patch 阶段；
- Patch，支持打补丁或复制预编译文件，找事 Patch 阶段；
- Copy，支持复制文件到指定目录，主要是 Patch 和 Install 阶段；
- Install，支持安装文件到指定目录，主要是 Install 阶段；
- Tar，支持打包目标文件，主要是 Package 阶段。

## 配置说明

### 配置选项

项目支持多种镜像构建，位于 `config/image/` 目录：

- **BuildRoot**：BuildRoot 配置；
- **BusyBox**：BusyBox 配置；
- **KyberEmu**：模拟器配置；
- **Linux**：Linux 配置；
- **U-Boot**：U-Boot 配置；
- **Ubuntu**：Ubuntu 系统配置。


### 构建方法

支持多种构建方法，位于 `image/method/` 目录, 以及多种构件类型，位于 `image/type/` 目录。

有关更多详细信息，请参阅 [image 文档](image/README_zh.md)。


## 虚拟工作台环境

虚拟工作台环境位于 `bench/` 目录，提供了：

- 虚拟环境构建和运行框架；
- 工作台镜像配置；
- 构建规则和工具；
- 对不同架构的支持。

有关更多详细信息，请参阅 [bench 文档](bench/README_zh.md)。

## 贡献指南

1. Fork 项目仓库；
2. 创建功能分支；
3. 提交更改；
4. 发起 Pull Request。

## 许可证

本项目采用 Apache License 2.0 许可证。详见 [LICENSE](LICENSE) 文件。


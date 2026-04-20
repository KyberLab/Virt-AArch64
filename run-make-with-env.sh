#!/bin/bash
# run-make-with-env.sh - 动态传参 + 默认追加 BENCH_CI_ENABLE=1
set -e  # 出错立即退出，便于排查问题

# ========== 核心配置 ==========
# 默认环境变量（固定追加）
DEFAULT_ENV="BENCH_CI_ENABLE=1"
# 项目根目录（替换为你的实际路径）
PROJECT_DIR="/opt/virt/KyberLab/Virt-AArch64"

# ========== 逻辑处理 ==========
# 1. 切换到项目目录（确保 make 命令在正确路径执行）
cd "${PROJECT_DIR}" || { echo "❌ 项目目录不存在：${PROJECT_DIR}"; exit 1; }

# 2. 拼接参数：默认环境变量 + Agent 传入的动态参数
# $@ 表示接收所有传入的动态参数（如 build、test、install PREFIX=/usr/local 等）
MAKE_ARGS="${DEFAULT_ENV} $@"

# 3. 非交互执行 make 命令（关闭标准输入，避免 TTY 错误）
echo "🔍 执行命令：make ${MAKE_ARGS}"
make ${MAKE_ARGS} < /dev/null

# 4. 输出执行结果
echo -e "\n✅ 命令执行完成！参数：${MAKE_ARGS}"
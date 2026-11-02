#!/usr/bin/env bash
set -euo pipefail
# Reason Network 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://reasonmachines.com/network
# 更新日期：2026-11-02
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

curl -fsSL https://reasonmachines.com/install.sh | bash -s -- network
reason-network who
echo "登录后把邀请链接发给队友，他们的电脑用同一账号加入"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://reasonmachines.com/network"

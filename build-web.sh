#!/usr/bin/env bash
# ClawPanel Web 构建脚本
# 用法:
#   ./build-web.sh                    — 构建 Web 版本
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
MAGENTA='\033[0;35m'; GRAY='\033[0;90m'; RESET='\033[0m'

step()  { echo -e "\n${CYAN}▶ $1${RESET}"; }
ok()    { echo -e "  ${GREEN}✓ $1${RESET}"; }
fail()  { echo -e "  ${RED}✗ $1${RESET}"; exit 1; }

echo ""
echo -e "  ${MAGENTA}ClawPanel Web 构建工具${RESET}"
echo -e "  ${GRAY}─────────────────────────────────────${RESET}"
echo ""

# ── 环境检测 ──────────────────────────────────────────────────────────────────

step "检查构建依赖"

if ! command -v node &>/dev/null; then
  fail "未找到 Node.js，请从 https://nodejs.org 安装 v18+"
fi
ok "Node.js $(node --version)"

# ── 依赖安装 ──────────────────────────────────────────────────────────────────

step "安装前端依赖"
if [ ! -d "node_modules" ]; then
  npm ci --silent
  ok "依赖安装完成"
else
  ok "依赖已存在，跳过"
fi

# ── 构建 ──────────────────────────────────────────────────────────────────────

START_TIME=$(date +%s)

step "构建 Web 版本"
npm run build

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

# ── 输出结果 ──────────────────────────────────────────────────────────────────

echo ""
echo -e "  ${GREEN}✅ 构建成功！耗时 ${ELAPSED}s${RESET}"
echo -e "  ${GRAY}─────────────────────────────────────${RESET}"
echo -e "  静态文件: ${GRAY}dist/${RESET}"
echo ""
echo -e "  ${GRAY}启动 Web 服务器:${RESET}"
echo -e "  ${GRAY}  npm run serve${RESET}"
echo ""
echo -e "  ${GRAY}开发模式:${RESET}"
echo -e "  ${GRAY}  npm run dev${RESET}"
echo ""

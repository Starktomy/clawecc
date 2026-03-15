#!/bin/bash
# ClawPanel Web 构建脚本
# 用法: ./scripts/build.sh

set -e
cd "$(dirname "$0")/.."

echo "🔨 构建 Web 版本..."
npm run build
echo "✅ 构建完成"
echo "   产物: dist/"
echo ""
echo "启动 Web 服务器: npm run serve"

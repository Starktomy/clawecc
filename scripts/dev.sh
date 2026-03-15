#!/bin/bash
# ClawPanel 开发模式启动脚本
# 用法: ./scripts/dev.sh

set -e
cd "$(dirname "$0")/.."

# 清理旧进程
cleanup() {
  echo "🧹 清理旧进程..."
  pkill -f "vite.*clawpanel" 2>/dev/null || true
  lsof -ti:1420 | xargs kill -9 2>/dev/null || true
  sleep 0.5
}

cleanup

echo "🌐 启动 Vite 前端开发服务器..."
echo "   地址: http://localhost:1420"
echo "   使用 dev-api 后端调用本机 OpenClaw CLI"
echo ""
npx vite --port 1420

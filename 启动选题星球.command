#!/bin/bash
# ORBIT 选题星球 — 本地启动器
# 双击即可运行。首次使用若提示"无法打开"，右键 → 打开。

cd "$(dirname "$0")"
PORT=4180

# 端口被占用时自动往后找
while lsof -i :$PORT >/dev/null 2>&1; do
  PORT=$((PORT+1))
done

echo "ORBIT 选题星球 正在启动…"
echo "地址：http://127.0.0.1:$PORT"
echo "关闭这个终端窗口即可停止。"
echo ""

python3 -m http.server $PORT --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER_PID=$!

sleep 1
open "http://127.0.0.1:$PORT"

trap "kill $SERVER_PID 2>/dev/null" EXIT
wait $SERVER_PID

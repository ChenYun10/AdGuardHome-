#!/bin/bash

# ------------ 配置部分 ------------
TARGET_DIR="/home/shdmt"  # 替换为目标目录
DOWNLOAD_URL="https://gh.llkk.cc/https://github.com/Potterli20/file/releases/download/dns-hosts-adgh-pro/dnshosts-adgh-pro-adguardhome-new-blacklist_full_combine.txt"  # 替换为实际下载链接
FILE_NAME="dnshosts-adgh-pro-adguardhome-new-blacklist_full_combine.txt"       # 下载后的文件名（可选，若不指定则保留原始名）
LOG_FILE="/var/log/auto-update-wget.log"  # 日志路径

# ------------ 脚本逻辑 ------------
# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error: Directory $TARGET_DIR does not exist." >> "$LOG_FILE"
  exit 1
fi

# 检查是否可写入目录
if [ ! -w "$TARGET_DIR" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error: No write permission in $TARGET_DIR." >> "$LOG_FILE"
  exit 1
fi

# 进入目标目录
cd "$TARGET_DIR" || exit 1

# 使用 wget 下载文件（-q 静默模式，-O 指定输出文件名）
if wget -q "$DOWNLOAD_URL" -O "$FILE_NAME"; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Success: Downloaded $DOWNLOAD_URL to $TARGET_DIR/$FILE_NAME." >> "$LOG_FILE"
else
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error: Failed to download $DOWNLOAD_URL." >> "$LOG_FILE"
  exit 1
fi

# ------------ 可选扩展 ------------
# 如果需要解压下载的压缩包（示例）：
# unzip -o "$FILE_NAME" >> "$LOG_FILE" 2>&1

# 如果需要删除旧文件后下载（示例）：
# rm -f old-file.txt && wget -q "$DOWNLOAD_URL" -O new-file.txt
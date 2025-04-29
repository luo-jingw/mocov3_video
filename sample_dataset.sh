#!/bin/bash

# 设置参数
SRC_ROOT="/root/autodl-tmp/kinetics-raw/raw/train"   # 原训练集路径
DST_ROOT="/root/autodl-tmp/kinetics-raw-mini/train"   # 小训练集目标路径
NUM_CLASSES=100                                        # 要采样的类别数
NUM_VIDEOS_PER_CLASS=20                               # 每个类别的视频数量

# 创建目标目录
mkdir -p $DST_ROOT

# 采样类别
SELECTED_CLASSES=($(ls $SRC_ROOT | shuf -n $NUM_CLASSES))

# 复制文件
for cls in "${SELECTED_CLASSES[@]}"; do
    mkdir -p "$DST_ROOT/$cls"
    for vid in $(ls "$SRC_ROOT/$cls" | shuf -n $NUM_VIDEOS_PER_CLASS); do
        cp "$SRC_ROOT/$cls/$vid" "$DST_ROOT/$cls/"
    done
done

echo "采样完成！已生成小型子集 $DST_ROOT"

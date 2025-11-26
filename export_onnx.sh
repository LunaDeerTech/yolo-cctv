#!/bin/bash

# 导出ONNX模型的脚本
# Script to export ONNX model

# 设置权重文件路径 (Set path to weights file)
# 通常使用 best.pt (Usually use best.pt)
WEIGHTS="runs/train/yolov7-cctv-320/weights/best.pt"

# 设置图片大小 (Set image size)
IMG_SIZE=320

# 检查是否安装了必要的库 (Check if necessary libraries are installed)
if ! python -c "import onnx" &> /dev/null; then
    echo "Installing onnx..."
    pip install onnx
fi

if ! python -c "import onnxsim" &> /dev/null; then
    echo "Installing onnx-simplifier..."
    pip install onnx-simplifier
fi

echo "Exporting $WEIGHTS to ONNX..."

# 运行导出命令 (Run export command)
# --grid: 导出 Detect() 层 grid (export Detect() layer grid)
# --end2end: 导出 end2end onnx (export end2end onnx)
# --simplify: 简化 onnx 模型 (simplify onnx model)
# --dynamic: 动态 batch (dynamic batch) - 可选 (optional)

# 获取绝对路径 (Get absolute path)
# WEIGHTS_ABS=$(realpath "$WEIGHTS")
WEIGHTS_ABS="$PWD/$WEIGHTS"

cd yolov7
python export.py \
    --dynamic \
    --grid \
    --weights "$WEIGHTS_ABS" \
    --img-size $IMG_SIZE $IMG_SIZE
cd ..

echo "Done."

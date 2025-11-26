#!/bin/bash

# Ensure weights exist
if [ ! -f "yolov7/yolov7_training.pt" ]; then
    echo "Downloading yolov7_training.pt..."
    wget -P yolov7/ https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7_training.pt
fi

# Run training
python yolov7/train.py \
    --workers 24 \
    --device 0 \
    --batch-size 32 \
    --data custom_config/data.yaml \
    --img 320 320 \
    --cfg yolov7/cfg/training/yolov7.yaml \
    --weights yolov7/yolov7_training.pt \
    --name yolov7-cctv-320 \
    --hyp yolov7/data/hyp.scratch.p5.yaml

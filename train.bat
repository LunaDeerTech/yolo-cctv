@echo off

REM Ensure weights exist
if not exist "yolov7\yolov7_training.pt" (
    echo Downloading yolov7_training.pt...
    curl -L -o yolov7\yolov7_training.pt https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7_training.pt
)

REM Run training
REM 注意: Windows下workers设置过大可能会导致报错，如果遇到问题请尝试减小workers数量 (例如改为 4 或 0)
python yolov7\train.py ^
    --workers 24 ^
    --device 0 ^
    --batch-size 32 ^
    --data custom_config\data.yaml ^
    --img 320 320 ^
    --cfg yolov7\cfg\training\yolov7.yaml ^
    --weights yolov7\yolov7_training.pt ^
    --name yolov7-cctv-320 ^
    --hyp yolov7\data\hyp.scratch.p5.yaml

pause

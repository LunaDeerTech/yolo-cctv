@echo off
REM 导出ONNX模型的脚本
REM Script to export ONNX model

REM 设置权重文件路径 (Set path to weights file)
REM 通常使用 best.pt (Usually use best.pt)
set "WEIGHTS=runs\train\yolov7-cctv-320\weights\best.pt"

REM 设置图片大小 (Set image size)
set IMG_SIZE=320

REM 检查是否安装了必要的库 (Check if necessary libraries are installed)
python -c "import onnx" >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing onnx...
    pip install onnx
)

python -c "import onnxsim" >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing onnx-simplifier...
    pip install onnx-simplifier
)

echo Exporting %WEIGHTS% to ONNX...

REM 运行导出命令 (Run export command)
REM --grid: 导出 Detect() 层 grid (export Detect() layer grid)
REM --end2end: 导出 end2end onnx (export end2end onnx)
REM --simplify: 简化 onnx 模型 (simplify onnx model)
REM --dynamic: 动态 batch (dynamic batch) - 可选 (optional)

REM 获取绝对路径 (Get absolute path)
set "WEIGHTS_ABS=%CD%\%WEIGHTS%"

cd yolov7
python export.py ^
    --dynamic ^
    --grid ^
    --weights "%WEIGHTS_ABS%" ^
    --img-size %IMG_SIZE% %IMG_SIZE%
cd ..

echo Done.
pause

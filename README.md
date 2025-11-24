# YOLOv7 Custom Object Detection for Home CCTV

This project is set up to train a custom YOLOv7 model to detect `person`, `face`, `cat`, and `dog`.

## Project Structure

```
.
├── custom_config/
│   └── data.yaml       # Dataset configuration
├── dataset/
│   ├── images/         # Images for training and validation
│   │   ├── train/
│   │   └── val/
│   └── labels/         # YOLO format labels
│       ├── train/
│       └── val/
├── yolov7/             # YOLOv7 repository (submodule)
├── requirements.txt    # Python dependencies
├── train.sh            # Training script
└── README.md           # This file
```

## Setup

1.  **Initialize Submodule (if not already done):**
    If you just cloned this repository, you might need to initialize the submodule:
    ```bash
    git submodule update --init --recursive
    ```

2.  **Install Dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

2.  **Download Pre-trained Weights:**
    You need the pre-trained weights to start training (transfer learning).
    ```bash
    cd yolov7
    wget https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7_training.pt
    cd ..
    ```

## Data Preparation

1.  **Collect Images:** Gather images from your home camera or other sources containing people, faces, cats, and dogs.
2.  **Label Images:** Use a tool like [LabelImg](https://github.com/heartexlabs/labelImg) or [CVAT](https://github.com/opencv/cvat) to annotate your images.
    *   **Classes:**
        *   0: person
        *   1: face
        *   2: cat
        *   3: dog
    *   **Format:** Save annotations in **YOLO** format (`.txt` files).
3.  **Organize Data:**
    *   Put training images in `dataset/images/train` and corresponding labels in `dataset/labels/train`.
    *   Put validation images in `dataset/images/val` and corresponding labels in `dataset/labels/val`.

## Training

To start training, run the provided script:

```bash
bash train.sh
```

This script runs the following command:
```bash
python yolov7/train.py --workers 4 --device 0 --batch-size 16 --data custom_config/data.yaml --img 640 640 --cfg yolov7/cfg/training/yolov7.yaml --weights yolov7/yolov7_training.pt --name yolov7-custom --hyp yolov7/data/hyp.scratch.p5.yaml
```

*   `--device 0`: Uses GPU 0. Change to `cpu` if you don't have a GPU (not recommended for training).
*   `--batch-size`: Adjust based on your GPU memory.

## Inference / Testing

To test your trained model:

```bash
python yolov7/detect.py --weights runs/train/yolov7-custom/weights/best.pt --conf 0.25 --img-size 640 --source your_video.mp4
```

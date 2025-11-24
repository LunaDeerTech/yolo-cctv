#!/usr/bin/env python3
import fiftyone as fo
import fiftyone.zoo as foz
import os
import yaml

def load_config(config_path):
    with open(config_path, 'r') as f:
        return yaml.safe_load(f)

def download_and_export(split, max_samples=None):
    """
    Downloads specific classes from Open Images V7 and exports to YOLO format.
    """
    print(f"Processing {split} split...")
    
    # Define classes to download
    # Note: Open Images class names are case sensitive and specific
    classes = ["Person", "Human face", "Cat", "Dog"]
    
    # Load the dataset from FiftyOne Zoo
    # This will download the data if not already present
    print(f"Loading/Downloading Open Images V7 ({split})...")
    dataset = foz.load_zoo_dataset(
        "open-images-v7",
        split=split,
        label_types=["detections"],
        classes=classes,
        max_samples=max_samples,
        shuffle=True,
        seed=42,
        only_matching=True,  # Only load images that contain the requested classes
    )

    # ...existing code...
    print(f"Dataset sample fields: {dataset.get_field_schema().keys()}")
    
    # Determine the label field
    label_field = "detections"
    if "detections" not in dataset.get_field_schema():
        print("WARNING: 'detections' field not found. Searching for Detections field...")
        for field, field_type in dataset.get_field_schema().items():
            print(f"Field: {field}, Type: {field_type}")
            if "Detections" in str(field_type):
                label_field = field
                print(f"Found Detections field: {label_field}")
                break
    
    print(f"Exporting {split} split to YOLO format using label_field='{label_field}'...")
    
    # Define export directory
    export_dir = "dataset"
    
    # Export to YOLOv5 format (compatible with YOLOv7)
    # This will create/append to:
    # dataset/images/split/
    # dataset/labels/split/
    # dataset/dataset.yaml
    dataset.export(
        export_dir=export_dir,
        dataset_type=fo.types.YOLOv5Dataset,
        label_field=label_field,
        split=split,
        classes=classes,
    )

if __name__ == "__main__":
    # Ensure fiftyone is installed
    # pip install fiftyone
    
    # Load configuration
    config_path = "custom_config/data.yaml"
    if os.path.exists(config_path):
        config = load_config(config_path)
        download_config = config.get('download', {})
        MAX_SAMPLES_TRAIN = download_config.get('max_samples_train', 2000)
        MAX_SAMPLES_VAL = download_config.get('max_samples_val', 500)
        print(f"Loaded configuration from {config_path}")
    else:
        print(f"Configuration file not found at {config_path}, using defaults.")
        MAX_SAMPLES_TRAIN = 2000
        MAX_SAMPLES_VAL = 500
    
    print("Starting download script...")
    print(f"Target classes: Person, Human face, Cat, Dog")
    print(f"Max samples - Train: {MAX_SAMPLES_TRAIN}, Val: {MAX_SAMPLES_VAL}")
    
    # Download Train
    download_and_export("train", max_samples=MAX_SAMPLES_TRAIN)
    
    # Download Validation
    download_and_export("validation", max_samples=MAX_SAMPLES_VAL)
    
    print("\nDownload and export complete!")
    print(f"Data is located in: {os.path.abspath('dataset')}")
    print("Please check 'dataset/dataset.yaml' for class mappings.")

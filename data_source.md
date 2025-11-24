# 数据集来源说明 (Data Sources)

为了满足 `person`, `face`, `cat`, `dog` 的检测需求，最推荐的数据集是 **Open Images Dataset V7**。它包含了所有这四个类别，并且开源协议友好。

## 1. Open Images Dataset V7 (推荐)

*   **官方网站**: [https://storage.googleapis.com/openimages/web/index.html](https://storage.googleapis.com/openimages/web/index.html)
*   **包含类别**:
    *   `Person` (人)
    *   `Human face` (人脸)
    *   `Cat` (猫)
    *   `Dog` (狗)
*   **开源许可**: CC-BY 4.0 (允许商业使用，需署名)
*   **数据量**: 非常巨大，但我们可以使用工具只下载特定类别的部分数据。

### 如何下载

我们推荐使用 Python 库 `fiftyone` 来下载和管理数据。它能自动处理复杂的元数据下载、类别筛选和格式转换。

**步骤:**

1.  安装 `fiftyone`:
    ```bash
    pip install fiftyone
    ```

2.  使用提供的脚本 `download_data.py` 进行下载。该脚本会自动下载指定类别的图片，并将其转换为 YOLO 格式。

## 2. COCO Dataset (备选)

*   **官方网站**: [https://cocodataset.org/](https://cocodataset.org/)
*   **包含类别**: `person`, `cat`, `dog` (缺少 `face`)
*   **说明**: COCO 是最常用的物体检测数据集，质量很高。如果你觉得 Open Images 的 `person`, `cat`, `dog` 质量不够，可以从 COCO 补充，但需要另外寻找人脸数据（如 WIDER FACE）。

## 3. WIDER FACE (仅人脸)

*   **官方网站**: [http://shuoyang1213.me/WIDERFACE/](http://shuoyang1213.me/WIDERFACE/)
*   **包含类别**: `Face`
*   **说明**: 专门的人脸检测数据集，难度较大（包含很多小人脸、遮挡人脸）。
*   **许可**: CC-BY-NC-ND (仅限非商业研究用途)。


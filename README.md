## DIDA: Dual-level Interaction for Domain Adaptive Semantic Segmentation

ICME 2023, Anonymous Authors 

Paper-id: 541



## Environmental Setup

For this project, we used python 3.8.5. We recommend setting up a new virtual
environment:

```shell
python -m venv ~/venv/dida
source ~/venv/dida/bin/activate
```

In that environment, the requirements can be installed with:

```shell
pip install -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html
pip install mmcv-full==1.4.0  # requires the other packages to be installed first
```

Further, please download the MiT weights using the
following script. 

### **Instructions for Manual Download:**

Please, download the [MiT weights](https://drive.google.com/drive/folders/1b7bwrInTW4VLEm27YawHOAMSMikga2Ia?usp=sharing)
pretrained on ImageNet-1K provided by the official
[SegFormer repository](https://github.com/NVlabs/SegFormer) and put them in a
folder `pretrained/` within this project. For most of the experiments, only mit_b5.pth is necessary.

All experiments were executed on a single NVIDIA RTX 3090.



## Inference Demo

For inferencing your own <demo.png>, please follow the following script

```shell
python -m image_demo demo.png path/to/your/own/checkpoint/<name of json file>.json path/to/your/own/checkpoint/latest.pth
```

When judging the predictions, please keep in mind that DIDA had no access to real-world labels during the training.



## Setup Datasets

**Cityscapes:** Please, download leftImg8bit_trainvaltest.zip and
gt_trainvaltest.zip from [here](https://www.cityscapes-dataset.com/downloads/)
and extract them to `data/cityscapes`.

**GTA:** Please, download all image and label packages from
[here](https://download.visinf.tu-darmstadt.de/data/from_games/) and extract
them to `data/gta`.

**Synthia (Optional):** Please, download SYNTHIA-RAND-CITYSCAPES from
[here](http://synthia-dataset.net/downloads/) and extract it to `data/synthia`.

The final folder structure should look like this:

```none
DIDA
├── ...
├── data
│   ├── cityscapes
│   │   ├── leftImg8bit
│   │   │   ├── train
│   │   │   ├── val
│   │   ├── gtFine
│   │   │   ├── train
│   │   │   ├── val
│   ├── gta
│   │   ├── images
│   │   ├── labels
│   ├── synthia (optional)
│   │   ├── RGB
│   │   ├── GT
│   │   │   ├── LABELS
├── ...
```

**Data Preprocessing:** Following DAFormer, please run the following scripts to convert the label IDs to the
train IDs and to generate the class index for RCS:

```shell
python tools/convert_datasets/gta.py data/gta --nproc 8
python tools/convert_datasets/cityscapes.py data/cityscapes --nproc 8
python tools/convert_datasets/synthia.py data/synthia/ --nproc 8
```



## Training

A training job can be launched using:

```shell
sh run_config.sh [gpuid]
```

For the two experiments conducted in our paper, we use a system to automatically generate
and train the configs:
gta->cs: expid == 7
synthia->cs: expid == 8

```shell
sh run_exp.sh [expid] [gpuid]
```

More information about the available experiments and their assigned IDs, can be
found in [experiments.py](experiments.py). Due to the double-blind rules, the generated configs will be opensourced upon publication.



## Testing & Predictions

### Manual Download

Please, download the [MiT weights](https://drive.google.com/drive/folders/1b7bwrInTW4VLEm27YawHOAMSMikga2Ia?usp=sharing) pretrained on ImageNet-1K provided by the official [SegFormer repository](https://github.com/NVlabs/SegFormer) and put them in a folder `pretrained/` within this project. For most of the experiments, only mit_b5.pth is necessary.



After training your own model, the checkpoint files and parameters will be saved to `work_dirs/local-<expid>/`.

Your own checkpoints trained on GTA→Cityscapes or Synthia→Cityscapes can be tested on the Cityscapes validation set using:

```shell
sh test.sh path/to/checkpoint_directory
```



## Framework Structure

DIDA mainly alters the UDA functions of Self-training.

The most relevant files for DIDA are:

* [models/uda/dacs.py](models/uda/dacs.py):
  Integrated implementations of UDA self-training.
  * Introduction of instance_loss (with Class Balanced Sampling and Boundary Pixel Selecting strategies)
  * Dual-level pseudo-label Interaction 
* [embedding_cache](embedding_cache):
  Our pre-generated *instance bank*, with class-balanced distribution of instance features.
* [create_buffer.py](create_buffer.py):
  generate vacant placeholders and initialize as unit random vectors

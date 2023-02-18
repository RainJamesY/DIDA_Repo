## DIDA: Dual-level Interaction for Domain Adaptive Semantic Segmentation

ICME 2023, Anonymous Authors 

Paper-id:541

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

## Manual Testing & Predictions with Checkpoints

* we will opensource our checkpoints upon publication


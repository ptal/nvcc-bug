Steps to replicate bug
======================

```
nvcc-bug$ nvcc main.cu
nvcc-bug$ ./a.out
In ru_cast(100000001): 100000000.000000
Rounding up of int(100000001) is expected to be 100000008.000000
Rounding up of int(100000001) on CPU is 100000008.000000
Rounding up of int(100000001) on GPU is 100000000.000000
```

Version infos
=============

```
nvcc-bug$ nvidia-smi
Mon Jul 18 09:46:39 2022
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 515.48.07    Driver Version: 515.48.07    CUDA Version: 11.7     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Quadro RTX 5000     On   | 00000000:01:00.0 Off |                  N/A |
| N/A   42C    P0    26W /  N/A |      5MiB / 16384MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1222      G   /usr/lib/xorg/Xorg                  4MiB |
+-----------------------------------------------------------------------------+
```
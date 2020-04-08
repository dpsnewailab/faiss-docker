### Docker Faiss and Python3 

https://hub.docker.com/r/kimnt93/nvidia-faiss-python


Faiss is a library for vectors search developed by Facebook AI Research. For more information on Faiss please visit https://github.com/facebookresearch/faiss

To start container with Python interface run 

`nvidia-docker run kimnt93/nvidia-faiss-python`


#### Build 

The lasted version run on <strong>GeForce GTX 1060</strong> with compute capability=6.1. You can build your own image 

``nvidia-docker build --build-arg <ARG> .``

with arguments

- `BUILD_CUDA_VERSION`: cuda version, default `BUILD_CUDA_VERSION=10` (see available tags at https://hub.docker.com/r/nvidia/cuda/)

- `FAISS_VERSION`: version of `faiss` https://github.com/facebookresearch/faiss

- `CC`: <strong>compute capability</strong> based on your GPU product. To know your `cc` please visit [this link](https://developer.nvidia.com/cuda-gpus). You must remove the `dot`, example <strong>GeForce GTX 1060</strong> has compute capability=7.5, so `CC=6.1`


#### Example 

If you want to build docker for <strong>Geforce RTX 2080 Ti</strong> model, run the command below:

``nvidia-docker build --build-arg CC=75 .``


#### License 
MIT
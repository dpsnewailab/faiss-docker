ARG BUILD_CUDA_VERSION=10.0

FROM nvidia/cuda:${BUILD_CUDA_VERSION}-devel AS build

RUN apt-get update && \
    apt-get install -y \
    libopenblas-dev \
    python3-numpy \
    python3-dev \
    swig \
    git \
    python3-pip

RUN git clone https://github.com/facebookresearch/faiss.git

ARG FAISS_VERSION=v1.6.3
ARG BUILD_CUDA_VERSION=10.0
ARG CC=61

RUN cd /faiss && \
#    git checkout tags/${FAISS_VERSION} -b build && \
    ./configure \
    --with-cuda=/usr/local/cuda-${BUILD_CUDA_VERSION} \
    --with-cuda-arch="-gencode=arch=compute_${CC},code=sm_${CC}" \
    --with-python=python3 && \
    make && \
    make py

# build python pip
ARG BUILD_CUDA_VERSION=10.0

FROM nvidia/cuda:${BUILD_CUDA_VERSION}-runtime-ubuntu18.04

RUN . /etc/os-release

RUN apt-get update && apt-get install -y python3-pip libopenblas-dev

COPY --from=build /faiss/python /python

RUN pip3 install pipenv && virtualenv -p python3 venv

ENV PATH="/venv/bin:$PATH"

RUN pip install python/ && rm -rf python

RUN python -c "import faiss"

ENTRYPOINT /bin/bash

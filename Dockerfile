FROM continuumio/miniconda3

LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

RUN \
    # Fetch additional libraries
    apt-get update -y && apt-get install -y cpio libcairo2-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev make jq npm && \ 
    # Clean cache
    apt-get clean

RUN git clone https://github.com/nilchia/cellxgene.git

WORKDIR cellxgene

# Switch to bash terminal to run "conda" commands
SHELL ["/bin/bash", "-c"]

RUN git checkout af8f1f469d8a84500abb59759affa4cb37ed0c37 && \
    source /opt/conda/etc/profile.d/conda.sh && \
    conda create -n cxg python=3.12 && \
    conda activate cxg && \
    make pydist && \
    make install-dist

ENV PATH=/opt/conda/envs/cxg/bin:$PATH
ENV CONDA_DEFAULT_ENV=cxg
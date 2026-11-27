FROM continuumio/miniconda3

LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

RUN \
    # Fetch additional libraries
    apt-get update -y && apt-get install -y cpio libcairo2-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev make jq npm net-tools && \
    # Clean cache
    apt-get clean

RUN git clone https://github.com/nilchia/cellxgene.git

WORKDIR /cellxgene

# Switch to bash terminal to run "conda" commands
SHELL ["/bin/bash", "-c"]

# checkout to latest commit on v_1.3.0 branch
RUN git checkout 96eb35b9c6741b6fd3a469e4d064f5f9e3861714 && \
    source /opt/conda/etc/profile.d/conda.sh && \
    conda create -n cxg python=3.12 && \
    conda activate cxg && \
    pip install anndata==0.13.4 numpy==2.1.0 pandas==2.3.3 && \
    pip install galaxy_ie_helpers && \
    make pydist && \
    make install-dist

ENV PATH=/opt/conda/envs/cxg/bin:$PATH
ENV CONDA_DEFAULT_ENV=cxg

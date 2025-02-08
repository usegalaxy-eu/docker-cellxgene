FROM continuumio/miniconda3

LABEL org.opencontainers.image.authors="Amirhossein"

# get cellxgene_VIP version 3.1
ADD https://github.com/interactivereport/cellxgene_VIP/archive/refs/tags/v3.1.tar.gz ./

# change directory
WORKDIR /cellxgene_VIP-3.1

ADD https://github.com/chanzuckerberg/cellxgene/archive/refs/tags/1.3.0.tar.gz ./

# rename the directory
RUN mv cellxgene-1.3.0 cellxgene && \
    # no need to install the cellxgene package with config.sh (comment out the lines)
    sed -i '/^git clone/,/^cd \.\.$/ s/^/#/' config.sh

# install the required packages
RUN conda config --set channel_priority flexible && \
    conda env create -n VIP -f VIP_conda_R.yml && \
    conda activate VIP && \
    ./config.sh && \
    export LIBARROW_MINIMAL=false && \
    unset R_LIBS_USER && \
    # install R packages
    R -q -e 'if(!require(devtools)) install.packages("devtools",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(Cairo)) devtools::install_version("Cairo",version="1.5-12",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(foreign)) devtools::install_version("foreign",version="0.8-76",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(ggpubr)) devtools::install_version("ggpubr",version="0.3.0",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(ggrastr)) devtools::install_version("ggrastr",version="0.2.1",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(arrow)) devtools::install_version("arrow",version="2.0.0",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(Seurat)) devtools::install_version("Seurat",version="3.2.3",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(rmarkdown)) devtools::install_version("rmarkdown",version="2.5",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(tidyverse)) devtools::install_version("tidyverse",version="1.3.0",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(viridis)) devtools::install_version("viridis",version="0.5.1",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(hexbin)) devtools::install_version("hexbin",version="1.28.2",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(ggforce)) devtools::install_version("ggforce",version="0.3.3",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(RcppRoll)) devtools::install_version("RcppRoll",version="0.3.0",repos = "http://cran.r-project.org")' && \
    R -q -e 'if(!require(fastmatch)) devtools::install_version("fastmatch",version="1.1-3",repos = "http://cran.r-project.org")' && \
    R -q -e 'if(!require(BiocManager)) devtools::install_version("BiocManager",version="1.30.10",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(fgsea)) BiocManager::install("fgsea")' && \
    R -q -e 'if(!require(rtracklayer)) BiocManager::install("rtracklayer")' && \
    R -q -e 'if(!require(rjson)) devtools::install_version("rjson",version="0.2.20",repos = "https://cran.us.r-project.org")' && \
    R -q -e 'if(!require(ComplexHeatmap)) BiocManager::install("ComplexHeatmap")' && \
    # These should be already installed as dependencies of above packages
    R -q -e 'if(!require(dbplyr)) devtools::install_version("dbplyr",version="1.0.2",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(RColorBrewer)) devtools::install_version("RColorBrewer",version="1.1-2",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(glue)) devtools::install_version("glue",version="1.4.2",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(gridExtra)) devtools::install_version("gridExtra",version="2.3",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(ggrepel)) devtools::install_version("ggrepel",version="0.8.2",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(MASS)) devtools::install_version("MASS",version="7.3-51.6",repos = "http://cran.us.r-project.org")' && \
    R -q -e 'if(!require(data.table)) devtools::install_version("data.table",version="1.13.0",repos = "http://cran.us.r-project.org")'

ENV CONDA_DEFAULT_ENV VIP
ENTRYPOINT ["cellxgene"]
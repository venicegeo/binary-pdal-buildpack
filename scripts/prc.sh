#!/bin/bash

apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        libboost-filesystem1.55-dev \
        libboost-iostreams1.55-dev \
        libboost-program-options1.55-dev \
        libboost-system1.55-dev \
        libboost-thread1.55-dev \
        libgdal1h \
        libgdal-dev \
        gdal-bin \
        libgeos-dev \
        libhpdf-dev \
    && rm -rf /var/lib/apt/lists/*

git clone https://github.com/PDAL/PRC.git \
    && cd PRC \
    && git checkout master \
    && mkdir build \
    && cd build \
    && cmake \
        -DCMAKE_BUILD_TYPE="Release" \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DPDAL_DIR=/usr/local/lib/pdal/cmake \
        .. \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf PRC

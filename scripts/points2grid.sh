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
    && rm -rf /var/lib/apt/lists/*

git clone https://github.com/CRREL/points2grid.git \
    && cd points2grid \
    && mkdir build \
    && cd build \
    && cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE="Release" \
        .. \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf points2grid

apt-get --purge autoremove -y \
    libboost-filesystem1.55-dev \
    libboost-iostreams1.55-dev \
    libboost-program-options1.55-dev \
    libboost-system1.55-dev \
    libboost-thread1.55-dev \
    libgdal1h \
    libgdal-dev \
    gdal-bin

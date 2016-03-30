#!/bin/bash
git clone https://github.com/LASzip/LASzip.git laszip \
    && cd laszip \
    && git checkout e7065cbc5bdbbe0c6e50c9d93d1cd346e9be6778 \
    && mkdir build \
    && cd build \
    && cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE="Release" \
        .. \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf laszip

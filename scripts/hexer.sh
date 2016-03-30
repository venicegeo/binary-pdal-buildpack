#!/bin/bash
git clone https://github.com/hobu/hexer.git \
    && cd hexer \
    && mkdir build \
    && cd build \
    && cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE="Release" \
        .. \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf hexer

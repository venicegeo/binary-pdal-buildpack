#!/bin/bash
git clone  https://github.com/verma/laz-perf.git \
    && cd laz-perf \
    && mkdir build \
    && cd build \
    && cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE="Release" \
        .. \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf laz-perf

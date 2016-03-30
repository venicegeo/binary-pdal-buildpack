#!/bin/bash

apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        automake \
        libproj-dev \
        libtool \
        subversion \
    && rm -rf /var/lib/apt/lists/*

svn co -r 2691 https://svn.osgeo.org/metacrs/geotiff/trunk/libgeotiff/ \
    && cd libgeotiff \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf libgeotiff

apt-get --purge autoremove -y subversion automake libtool libproj-dev

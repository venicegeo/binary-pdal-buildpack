#!/bin/bash

apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        libarpack2-dev \
        libflann-dev \
        liblapack-dev \
        libboost-filesystem1.55-dev \
        libboost-iostreams1.55-dev \
        libboost-program-options1.55-dev \
        libboost-system1.55-dev \
        libboost-thread1.55-dev \
    && rm -rf /var/lib/apt/lists/*

git clone https://github.com/chambbj/pcl.git \
        && cd pcl \
        && git checkout pcl-1.7.2-sans-opengl \
        && mkdir build \
        && cd build \
        && cmake \
                -DBUILD_2d=ON \
                -DBUILD_CUDA=OFF \
                -DBUILD_GPU=OFF \
                -DBUILD_apps=OFF \
                -DBUILD_common=ON \
                -DBUILD_examples=OFF \
                -DBUILD_features=ON \
                -DBUILD_filters=ON \
                -DBUILD_geometry=ON \
                -DBUILD_global_tests=OFF \
                -DBUILD_io=ON \
                -DBUILD_kdtree=ON \
                -DBUILD_keypoints=ON \
                -DBUILD_ml=ON \
                -DBUILD_octree=ON \
                -DBUILD_outofcore=OFF \
                -DBUILD_people=OFF \
                -DBUILD_recognition=OFF \
                -DBUILD_registration=ON \
                -DBUILD_sample_concensus=ON \
                -DBUILD_search=ON \
                -DBUILD_segmentation=ON \
                -DBUILD_simulation=OFF \
                -DBUILD_stereo=OFF \
                -DBUILD_surface=ON \
                -DBUILD_surface_on_nurbs=OFF \
                -DBUILD_tools=OFF \
                -DBUILD_tracking=OFF \
                -DBUILD_visualization=OFF \
                -DWITH_LIBUSB=OFF \
                -DWITH_OPENNI=OFF \
                -DWITH_OPENNI2=OFF \
                -DWITH_FZAPI=OFF \
                -DWITH_PXCAPI=OFF \
                -DWITH_PNG=OFF \
                -DWITH_QHULL=OFF \
                -DWITH_QT=OFF \
                -DWITH_VTK=OFF \
                -DWITH_PCAP=OFF \
                -DCMAKE_INSTALL_PREFIX=/usr/local \
                -DCMAKE_BUILD_TYPE="Release" \
                .. \
        && make \
        && make install \
        && cd / \
        && rm -rf pcl

apt-get --purge autoremove -y \
    libarpack2-dev \
    libflann-dev \
    liblapack-dev \
    libboost-filesystem1.55-dev \
    libboost-iostreams1.55-dev \
    libboost-program-options1.55-dev \
    libboost-system1.55-dev \
    libboost-thread1.55-dev

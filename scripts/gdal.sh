#!/bin/bash

# apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 16126D3A3E5C1192
# apt-get update -qq
# apt-get -qq remove postgis

# gfortran on down shouldn't be needed, i don't think, but it's not compiling, so we'll try
apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        build-essential \
        ca-certificates \
        git \
        libarmadillo-dev \
        libgeos-dev \
        libhdf4-alt-dev \
        libhdf5-dev \
        libhdf5-serial-dev \
        libjasper-dev \
        libjpeg-dev \
        libnetcdf-dev \
        libproj-dev \
        libspatialite-dev \
        libsqlite3-dev \
        gfortran \
        libarpack2-dev \
        libflann-dev \
        liblapack-dev \
        libtiff5-dev \
        openssh-client \
        python-dev \
        python-numpy \
        python-software-properties \
        software-properties-common \
        automake \
        libtool \
        libjsoncpp-dev \
        libboost-filesystem1.55-dev \
        libboost-iostreams1.55-dev \
        libboost-program-options1.55-dev \
        libboost-system1.55-dev \
        libboost-thread1.55-dev \
        clang \
        libc6-dev \
        libpng-dev \
        libgif-dev \
        libwebp-dev \
        libpq-dev \
        libxerces-c-dev \
        unixodbc-dev \
        libmysqlclient-dev \
        libltdl-dev \
        libcurl4-openssl-dev \
        libdap-dev\
        cython \
        python-pip \
    && rm -rf /var/lib/apt/lists/*

git clone --depth=1 https://github.com/OSGeo/gdal.git \
    &&    cd gdal/gdal \
    && ./configure --prefix=/usr/local \
            --mandir=/usr/local/share/man \
            --includedir=/usr/local/include/gdal \
            --with-threads \
            --with-grass=no \
            --with-hide-internal-symbols=yes \
            --with-rename-internal-libtiff-symbols=yes \
            --with-rename-internal-libgeotiff-symbols=yes \
            --with-libtiff=internal \
            --with-geotiff=internal \
            --with-webp \
            --with-jasper \
            --with-netcdf \
            --with-hdf5=/usr/lib/x86_64-linux-gnu/hdf5/serial/ \
            --with-xerces \
            --with-geos \
            --with-sqlite3 \
            --with-curl \
            --with-pg \
            --with-mysql \
            --with-python \
            --with-odbc \
            --with-ogdi \
            --with-dods-root=/usr \
            --with-spatialite=/usr \
            --with-cfitsio=no \
            --with-ecw=no \
            --with-mrsid=no \
            --with-poppler=yes \
            --with-openjpeg=yes \
            --with-freexl=yes \
            --with-libkml=yes \
            --with-armadillo=yes \
            --with-liblzma=yes \
            --with-epsilon=/usr \
    && make -j4 \
    && make install

apt-get --purge autoremove -y \
    build-essential \
    ca-certificates \
    git \
    libarmadillo-dev \
    libgeos-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    libjasper-dev \
    libjpeg-dev \
    libnetcdf-dev \
    libproj-dev \
    libspatialite-dev \
    libsqlite3-dev \
    gfortran \
    libarpack2-dev \
    libflann-dev \
    liblapack-dev \
    libtiff5-dev \
    openssh-client \
    python-dev \
    python-numpy \
    python-software-properties \
    software-properties-common \
    automake \
    libtool \
    libjsoncpp-dev \
    libboost-filesystem1.55-dev \
    libboost-iostreams1.55-dev \
    libboost-program-options1.55-dev \
    libboost-system1.55-dev \
    libboost-thread1.55-dev \
    clang \
    libc6-dev \
    libpng-dev \
    libgif-dev \
    libwebp-dev \
    libpq-dev \
    libxerces-c-dev \
    unixodbc-dev \
    libmysqlclient-dev \
    libltdl-dev \
    libcurl4-openssl-dev \
    libdap-dev\
    cython \
    python-pip

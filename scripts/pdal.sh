#!/bin/bash

# apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 16126D3A3E5C1192
# apt-get update -qq
# apt-get -qq remove postgis

apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        libgdal1h \
        libgdal-dev \
        gdal-bin \
        gfortran \
        libflann-dev \
        libhdf5-serial-dev \
        libtiff5-dev \
        python-dev \
        python-numpy \
        python-software-properties \
        software-properties-common \
        libspatialite-dev \
        libhdf5-dev \
        libjsoncpp-dev \
        libboost-filesystem1.55-dev \
        libboost-iostreams1.55-dev \
        libboost-program-options1.55-dev \
        libboost-system1.55-dev \
        libboost-thread1.55-dev \
        clang \
        libproj-dev \
        libc6-dev \
        libnetcdf-dev \
        libjasper-dev \
        libpng-dev \
        libjpeg-dev \
        libgif-dev \
        libwebp-dev \
        libhdf4-alt-dev \
        libhdf5-dev \
        libpq-dev \
        libxerces-c-dev \
        unixodbc-dev \
        libsqlite3-dev \
        libgeos-dev \
        libmysqlclient-dev \
        libltdl-dev \
        libcurl4-openssl-dev \
        libspatialite-dev \
        libdap-dev\
        cython \
        python-pip \
    && rm -rf /var/lib/apt/lists/*

git clone --depth=1 https://github.com/PDAL/PDAL \
	&& cd PDAL \
	&& git checkout master \
	&& mkdir build \
	&& cd build \
	&& cmake \
		-DBUILD_PLUGIN_CPD=OFF \
		-DBUILD_PLUGIN_GREYHOUND=OFF \
		-DBUILD_PLUGIN_HEXBIN=ON \
		-DBUILD_PLUGIN_ICEBRIDGE=ON \
		-DBUILD_PLUGIN_MRSID=ON \
		-DBUILD_PLUGIN_NITF=ON \
		-DBUILD_PLUGIN_OCI=OFF \
		-DBUILD_PLUGIN_P2G=ON \
		-DBUILD_PLUGIN_PCL=ON \
		-DBUILD_PLUGIN_PGPOINTCLOUD=ON \
		-DBUILD_PLUGIN_SQLITE=ON \
		-DBUILD_PLUGIN_RIVLIB=OFF \
		-DBUILD_PLUGIN_PYTHON=ON \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DENABLE_CTEST=OFF \
		-DWITH_APPS=ON \
		-DWITH_LAZPERF=ON \
		-DWITH_GEOTIFF=ON \
		-DWITH_LASZIP=ON \
		-DWITH_TESTS=ON \
		-DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
		.. \
	&& make \
	&& make install \
  && cd / \
  && rm -rf PDAL

apt-get --purge autoremove -y \
        libgdal1h \
        libgdal-dev \
        gdal-bin \
        gfortran \
        libflann-dev \
        libhdf5-serial-dev \
        libtiff5-dev \
        python-dev \
        python-numpy \
        python-software-properties \
        software-properties-common \
        libspatialite-dev \
        libhdf5-dev \
        libjsoncpp-dev \
        libboost-filesystem1.55-dev \
        libboost-iostreams1.55-dev \
        libboost-program-options1.55-dev \
        libboost-system1.55-dev \
        libboost-thread1.55-dev \
        clang \
        libproj-dev \
        libc6-dev \
        libnetcdf-dev \
        libjasper-dev \
        libpng-dev \
        libjpeg-dev \
        libgif-dev \
        libwebp-dev \
        libhdf4-alt-dev \
        libhdf5-dev \
        libpq-dev \
        libxerces-c-dev \
        unixodbc-dev \
        libsqlite3-dev \
        libgeos-dev \
        libmysqlclient-dev \
        libltdl-dev \
        libcurl4-openssl-dev \
        libspatialite-dev \
        libdap-dev\
        cython \
        python-pip

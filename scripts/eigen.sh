#!/bin/bash
apt-get update && apt-get install -y --fix-missing --no-install-recommends \
        wget \
    && rm -rf /var/lib/apt/lists/*

wget http://bitbucket.org/eigen/eigen/get/3.2.7.tar.gz \
        && tar -xvf 3.2.7.tar.gz \
        && cp -R eigen-eigen-b30b87236a1b/Eigen/ /usr/local/include/Eigen/ \
        && cp -R eigen-eigen-b30b87236a1b/unsupported/ /usr/local/include/unsupported/

apt-get --purge autoremove -y wget

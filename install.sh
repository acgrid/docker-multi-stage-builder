#!/usr/bin/env bash
source /etc/profile.d/build-env.sh

CMAKE_VERSION=${CMAKE_VERSION}
LIBZIP_VERSION=${LIBZIP_VERSION}
BUILD_ASSETS_DIR=${BUILD_ASSETS_DIR}
BUILD_PREFIX_DIR=${BUILD_PREFIX_DIR}

set -e

yum update -y && yum install -y epel-release
yum install -y git gcc gcc-c++ make automake autoconf bison perl file tar re2c libtool wget bzip2 mlocate which

wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh
bash cmake-${CMAKE_VERSION}-Linux-x86_64.sh --skip-license --prefix=/usr && rm -f cmake-${CMAKE_VERSION}-Linux-x86_64.sh

mkdir -p ${BUILD_PREFIX_DIR}
echo ${BUILD_PREFIX_DIR}/lib/ > /etc/ld.so.conf.d/custom-libs.conf
echo ${BUILD_PREFIX_DIR}/lib64/ >> /etc/ld.so.conf.d/custom-libs.conf

set +e
strip_debug /usr/bin/ "*"
strip_debug /usr/sbin/ "*"
strip_debug /usr/lib/ "*.so"
strip_debug /usr/lib/ "*.so.*"
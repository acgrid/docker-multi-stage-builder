#!/usr/bin/env bash
BUILD_ASSETS_DIR=${BUILD_ASSETS_DIR}

export BUILD_ROOT_DIR="${BUILD_ASSETS_DIR}/rootfs"
export BUILD_PREFIX_DIR="${BUILD_ROOT_DIR}/usr"

export PKG_CONFIG_PATH="/usr/lib/pkgconfig:${BUILD_PREFIX_DIR}/lib/pkgconfig"
export LD_LIBRARY_PATH="/lib:/usr/lib:/usr/lib64:/usr/local/lib:${BUILD_PREFIX_DIR}/lib"
export CPPFLAGS="-I${BUILD_PREFIX_DIR}/include"
export LDFLAGS="-L${BUILD_PREFIX_DIR}/lib"

download_and_extract() {
  src=${1}
  dest=${2}
  tarball=$(basename ${src})

  if [[ ! -f ${tarball} ]]; then
    echo "Downloading ${1}..."
    wget ${src} -O ${tarball}
  fi

  echo "Extracting ${tarball}..."
  mkdir ${dest}
  tar xf ${tarball} --strip=1 -C ${dest} && rm -f ${tarball}
}

strip_debug() {
  local dir=${1}
  local filter=${2}
  for f in $(find "${dir}" -name "${filter}")
  do
    if [[ -f ${f} ]]; then
      strip --strip-all ${f}
    fi
  done
}
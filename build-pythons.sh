#!/usr/bin/env bash

set -euo pipefail

PREFIX="${PREFIX:-/opt/python}"
BUILDDIR="${BUILDDIR:-/opt/python-build}"

declare -A PYTHONS=(
  [3.14.0]=https://www.python.org/ftp/python/3.14.0/Python-3.14.0.tar.xz
  [3.14.2]=https://www.python.org/ftp/python/3.14.2/Python-3.14.2.tar.xz
)

for version in ${!PYTHONS[@]}; do
  srcdir="${BUILDDIR}/${version}"
  mkdir -p "${srcdir}"
  (
    cd "${srcdir}"
    curl -fL "${PYTHONS[${version}]}" -O
    tar -xaf "$(basename "${PYTHONS[${version}]}")"
    cd "Python-${version}"
    LDFLAGS="-Wl,--build-id=none -Wl,-rpath,${PREFIX}/lib" \
      ./configure \
        --prefix=${PREFIX} \
        --enable-shared \
        --without-static-libpython
    make -j$(nproc)
  )
done


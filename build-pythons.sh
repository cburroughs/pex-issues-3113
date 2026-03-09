#!/usr/bin/env bash

set -euo pipefail

PREFIX="${PREFIX:-/tmp/pex-enable-shared/snakes}"

declare -A PYTHONS=(
  [3.14.0]=https://www.python.org/ftp/python/3.14.0/Python-3.14.0.tar.xz
  [3.14.2]=https://www.python.org/ftp/python/3.14.2/Python-3.14.2.tar.xz
  [3.14.3]=https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tar.xz
)

CLEANUP=()

cleanup() {
  for path in "${CLEANUP[@]}"; do
    rm -rf ${path}
  done
}

trap cleanup EXIT

safe_mkdtemp() {
  dir="$(mktemp -d)"
  CLEANUP+=("${dir}")
  echo "${dir}"
}

for version in ${!PYTHONS[@]}; do
  workdir="$(safe_mkdtemp)"
  (
    cd "${workdir}"
    python="${PYTHONS[${version}]}"
    curl -fL "${python}" -O
    tar -xaf "$(basename "${python}")"
    cd "Python-${version}"
    prefix="${PREFIX}/${version}"
    LDFLAGS="-Wl,--build-id=none -Wl,-rpath,${prefix}/lib" \
      ./configure \
        --prefix=${prefix} \
        --enable-shared \
        --without-static-libpython
    make -j$(nproc)
    make altinstall
    strip "${prefix}/bin/python${version%.*}"
  )
done


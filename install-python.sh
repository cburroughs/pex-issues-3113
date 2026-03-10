#!/usr/bin/env bash

set -euo pipefail

PREFIX="${PREFIX:-/opt/python}"
BUILDDIR="${BUILDDIR:-/opt/python-build}"

version="${1:?Usage: $0 <version>  (e.g. 3.14.0)}"

srcdir="${BUILDDIR}/${version}/Python-${version}"
if [ ! -d "${srcdir}" ]; then
  echo "No build found at ${srcdir}" >&2
  exit 1
fi

logfile="/tmp/install-python-${version}.log"
make -C "${srcdir}" altinstall > "${logfile}" 2>&1
echo "Install log: ${logfile}"
strip "${PREFIX}/bin/python${version%.*}"

echo "Installed Python ${version} to ${PREFIX}"
sha256sum "${PREFIX}/bin/python${version%.*}"
"${PREFIX}/bin/python${version%.*}" --version

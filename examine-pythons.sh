#!/usr/bin/env bash

set -euo pipefail

PREFIX="${PREFIX:-/tmp/pex-enable-shared/snakes}"

find "${PREFIX}" -regex ".*/bin/python[0-9]\.[0-9]+" -o -regex ".*/lib/.*libpython.*\.so\..*" | \
  sort | while read file; do
  sha256sum "${file}"
  file "${file}"
done


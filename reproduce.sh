#!/usr/bin/env bash

set -euo pipefail

PREFIX="${PREFIX:-/opt/python}"
PEX_ROOT="/tmp/pex-repro"

PEX_ROOT="${PEX_ROOT}" /usr/local/bin/pex cowsay -c cowsay -o /tmp/cowsay.pex


echo
echo "=== Installing Python 3.14.0 ==="
./install-python.sh 3.14.0

echo
echo "=== Creating venv from 3.14.0, running cowsay.pex ==="
"${PREFIX}/bin/python3.14" -m venv /tmp/venv-3.14.0
PEX_ROOT="${PEX_ROOT}" /tmp/venv-3.14.0/bin/python /tmp/cowsay.pex -t "I am 3.14.0"

echo
echo "=== Installing Python 3.14.2 ==="
./install-python.sh 3.14.2

echo
echo "=== Creating venv from 3.14.2, running cowsay.pex ==="
"${PREFIX}/bin/python3.14" -m venv /tmp/venv-3.14.2
PEX_ROOT="${PEX_ROOT}" /tmp/venv-3.14.2/bin/python /tmp/cowsay.pex -t "I am 3.14.2"

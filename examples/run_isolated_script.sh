#!/usr/bin/env bash
# Example: Running an untrusted Python script safely inside nanobox
set -euo pipefail

nanobox spawn untrusted-env
cat << 'PY' > ~/.nanobox/untrusted-env/script.py
import sys
print("[SANDBOX] Isolated execution successful!")
PY

echo "[+] Spawning container environment..."
# nanobox run ~/.nanobox/untrusted-env /bin/sh

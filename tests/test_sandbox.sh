#!/usr/bin/env bash
# Test suite for nanobox
set -euo pipefail

echo "=== Running nanobox Integration Tests ==="
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# 1. Version test
"$BASE_DIR/nanobox.sh" version | grep -q "nanobox version"
echo "[+] Test 1: Version check passed."

# 2. Spawn test
"$BASE_DIR/nanobox.sh" spawn test-box
if [ -d "$HOME/.nanobox/test-box" ]; then
    echo "[+] Test 2: Workspace creation passed."
    rm -rf "$HOME/.nanobox/test-box"
fi

echo "All nanobox tests passed."

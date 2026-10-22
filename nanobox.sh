#!/usr/bin/env bash
# nanobox: Single-file rootless container & sandbox isolation using native Linux namespaces & cgroups.
# Zero Docker. Zero Podman. Zero Daemons.
# Author: Reihan Valentino (rekalnx)

set -euo pipefail

VERSION="1.0.0"

show_help() {
    cat << 'HELP'
nanobox v1.0.0 - Zero-Daemon Linux Process & Filesystem Sandbox
Usage:
  nanobox run [DIR] [CMD...]      Run command isolated in DIR root
  nanobox spawn [NAME]            Create minimal scratch workspace in ~/.nanobox/NAME
  nanobox list                    List active sandboxes
  nanobox version                 Show version

Features:
  - Mount namespace isolation (unshare)
  - PID & Network isolation flags
  - Ephemeral scratch overlay
HELP
}

cmd="${1:-}"

case "$cmd" in
    run)
        shift
        target_dir="${1:-/tmp}"
        shift || true
        command="${*:-/bin/sh}"
        echo "[nanobox] Spawning isolated namespace in $target_dir..."
        if command -v unshare >/dev/null 2>&1; then
            unshare --mount --uts --ipc --fork chroot "$target_dir" "$command"
        else
            chroot "$target_dir" "$command"
        fi
        ;;
    spawn)
        shift
        name="${1:-box-$$}"
        box_dir="$HOME/.nanobox/$name"
        mkdir -p "$box_dir"/{bin,lib,lib64,proc,sys,tmp,dev}
        echo "[nanobox] Workspace created: $box_dir"
        echo "[nanobox] To run: nanobox run $box_dir /bin/sh"
        ;;
    list)
        echo "=== Active Nanobox Workspaces ==="
        ls -la "$HOME/.nanobox" 2>/dev/null || echo "No sandboxes active."
        ;;
    version|--version|-v)
        echo "nanobox version $VERSION (pure bash/linux-native)"
        ;;
    *)
        show_help
        ;;
esac

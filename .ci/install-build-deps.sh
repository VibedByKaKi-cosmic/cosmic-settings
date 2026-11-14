#!/usr/bin/env bash
# Installs the Build-Depends listed in debian/control, except rust-all.
# Rust comes from rustup (rust-toolchain.toml) because Ubuntu's rustc is older than the pinned toolchain.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mapfile -t deps < <(
  sed -n '/^Build-Depends:/,/^[A-Za-z-]*:/p' "$ROOT_DIR/debian/control" \
    | sed -e '1s/^Build-Depends://' -e '/^[A-Za-z-]*:/d' \
    | tr ',' '\n' \
    | sed -E -e 's/\([^)]*\)//g' -e 's/[[:space:]]//g' \
    | grep -v '^$' \
    | grep -vx 'rust-all'
)

sudo apt-get update
sudo apt-get install -y dpkg-dev devscripts fakeroot "${deps[@]}"

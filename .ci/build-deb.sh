#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

: "${DEB_VERSION:?DEB_VERSION must be set (run .ci/set-version.sh first)}"

ARTIFACT_DIR="${ARTIFACT_DIR:-$ROOT_DIR/artifacts}"
BUILD_ROOT="$(mktemp -d)"

cleanup() {
  rm -rf "$BUILD_ROOT"
}
trap cleanup EXIT

if [[ "$(dpkg --print-architecture)" != "amd64" ]]; then
  echo "error: this build only targets amd64" >&2
  exit 1
fi

mkdir -p "$ARTIFACT_DIR"
cp -a "$ROOT_DIR/." "$BUILD_ROOT/cosmic-settings"

cd "$BUILD_ROOT/cosmic-settings"

export DEBFULLNAME="${DEBFULLNAME:-COSMIC Settings CI}"
export DEBEMAIL="${DEBEMAIL:-ci@cosmic-settings.local}"

dch --newversion "$DEB_VERSION" \
  --distribution noble \
  "Automated CI build from ${SOURCE_SHA:-${GITHUB_SHA:-local}}" < /dev/null

# -d skips the Build-Depends check because rust-all is intentionally not installed.
dpkg-buildpackage -d -us -uc -b -rfakeroot

shopt -s nullglob
debs=( "$BUILD_ROOT"/*.deb )
if (( ${#debs[@]} == 0 )); then
  echo "error: dpkg-buildpackage produced no .deb" >&2
  exit 1
fi

for deb in "${debs[@]}"; do
  cp -v "$deb" "$ARTIFACT_DIR/"
done

ls -la "$ARTIFACT_DIR"

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

UPSTREAM_VERSION="$(awk '/^\[package\]/ {p = 1; next} /^\[/ {p = 0} p && /^version/ {gsub(/"/, "", $3); print $3; exit}' cosmic-settings/Cargo.toml)"
: "${UPSTREAM_VERSION:?could not read version from cosmic-settings/Cargo.toml}"

SOURCE_SHA="$(git rev-parse HEAD)"
SHORT_SHA="${SOURCE_SHA:0:7}"
DEB_VERSION="${UPSTREAM_VERSION}-1+git${SHORT_SHA}"
TAG="v${UPSTREAM_VERSION}+git.${SHORT_SHA}"
TITLE="COSMIC Settings ${UPSTREAM_VERSION} (${SHORT_SHA})"

export UPSTREAM_VERSION DEB_VERSION SHORT_SHA SOURCE_SHA TAG TITLE

echo "Package version set to ${DEB_VERSION}"

if [[ -n "${GITHUB_ENV:-}" ]]; then
  {
    echo "UPSTREAM_VERSION=${UPSTREAM_VERSION}"
    echo "DEB_VERSION=${DEB_VERSION}"
    echo "SHORT_SHA=${SHORT_SHA}"
    echo "SOURCE_SHA=${SOURCE_SHA}"
    echo "TAG=${TAG}"
    echo "TITLE=${TITLE}"
  } >> "$GITHUB_ENV"
fi

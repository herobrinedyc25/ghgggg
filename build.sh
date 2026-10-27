#!/usr/bin/env bash
set -euo pipefail
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="2025.02.10"
if [ ! -d "$BASE/buildroot" ]; then
  echo "Téléchargement Buildroot $VERSION..."
  curl -fL "https://buildroot.org/downloads/buildroot-${VERSION}.tar.gz" -o "$BASE/buildroot.tar.gz"
  tar -xzf "$BASE/buildroot.tar.gz" -C "$BASE"
  mv "$BASE/buildroot-${VERSION}" "$BASE/buildroot"
fi
cd "$BASE/buildroot"
cp "$BASE/config/minios_defconfig" configs/minios_defconfig
make minios_defconfig
make -j"$(nproc)"
echo "Images disponibles dans: $BASE/buildroot/output/images"

#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p buildroot
docker compose build
docker compose run --rm build-minios
printf '\nImages: %s/buildroot/output/images/\n' "$PWD"

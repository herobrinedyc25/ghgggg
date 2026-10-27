#!/usr/bin/env bash
set -euo pipefail
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMG="$BASE/buildroot/output/images"
[ -f "$IMG/bzImage" ] || { echo 'Construisez le système avec scripts/build.sh'; exit 1; }
[ -f "$IMG/rootfs.ext2" ] || { echo 'Image rootfs.ext2 absente'; exit 1; }
exec qemu-system-x86_64 -m 512 -nographic -kernel "$IMG/bzImage" -drive "file=$IMG/rootfs.ext2,format=raw,if=virtio" -append 'root=/dev/vda console=ttyS0 rw' -no-reboot

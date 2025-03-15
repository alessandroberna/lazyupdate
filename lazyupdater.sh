#!/bin/bash
# This script updates the pkgver value in a PKGBUILD file.
# Usage: ./update_pkgver.sh <new_version>
# Copyright © 2025 Alessandro Bernardello

set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <new_version>"
  exit 1
fi

new_version="$1"

if [ ! -f "PKGBUILD" ]; then
  echo "Error: PKGBUILD file not found in the current directory."
  exit 1
fi

# update pkgver before sourcing
echo "Updating PKGBUILD"
sed -i "s/^\(pkgver=\).*/\1${new_version}/" PKGBUILD
updpkgsums 
makepkg --printsrcinfo > .SRCINFO

# shellcheck disable=SC1091
source PKGBUILD

echo "Building package"
makepkg -f

# shellcheck disable=SC2154
# todo: use actual $ARCH instead of hardcoding
# todo: read package extension from makepkg.conf
sudo pacman -U "$pkgname"-"$pkgver"-"$pkgrel"-x86_64.pkg.tar.zst
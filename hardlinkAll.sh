#!/bin/bash
# Hardlinks all files from a source directory to a destination directory.
# Usage: ./hardlinkAll.sh <source directory> <destination basedir>
# A new directory will be created in the destination basedir with the same name as the source directory.
# Copyright © 2025 Alessandro Bernardello

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source directory> <destination basedir>"
  exit 1
fi

SRC=$(realpath "$1")
DSTBASE="$2"

if [ ! -d "$SRC" ]; then
  echo "Error: Source directory '$SRC' does not exist."
  exit 1
fi

DSTNAME=$(basename "$SRC") 
DST=$(realpath "$DSTBASE/$DSTNAME")

if [ ! -d "$DST" ]; then
    mkdir -p "$DST"
fi

for file in "$SRC"/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    ln "$file" "$DST/$filename"
  fi
done

echo "All files from '$SRC' have been hardlinked to '$DST'."

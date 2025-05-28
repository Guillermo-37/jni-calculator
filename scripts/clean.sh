#!/bin/bash
source "$(dirname "$0")/env/variables.sh"

echo "Cleaning build directory: $OUTPUT_DIR"
rm -rf build

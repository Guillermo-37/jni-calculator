#!/bin/bash
set -e

# Load common environment variables
source "$(dirname "$0")/env/variables.sh"

# Ensure everything is built
scripts/build_and_run.sh

# Read Native-Library-Path from manifest
NATIVE_LIB_PATH=$(grep '^Native-Library-Path:' "$OUTPUT_DIR/$MANIFEST" | cut -d' ' -f2-)

if [ -z "$NATIVE_LIB_PATH" ]; then
    echo "Error: Native-Library-Path not found in manifest."
    exit 1
fi

# Resolve to absolute path if not already
if [[ "$NATIVE_LIB_PATH" != /* ]]; then
    NATIVE_LIB_PATH="$OUTPUT_DIR/$NATIVE_LIB_PATH"
fi

echo "Building and running the project..."

if [ ! -f "$OUTPUT_DIR/$JAR_NAME" ]; then
    echo "Error: JAR file not found at $OUTPUT_DIR/$JAR_NAME. Please build the project first."
    exit 1
fi

java -Djava.library.path="$NATIVE_LIB_PATH" -jar "$OUTPUT_DIR/$JAR_NAME" 
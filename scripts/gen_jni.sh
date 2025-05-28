#!/bin/bash
set -e

# Load common environment variables
source "$(dirname "$0")/env/variables.sh"

echo "Generating JNI headers and C stubs..."

mkdir -p "$JAVA_OUT" "$JNI_OUT" "$HEADER_OUT"

# Compile all Java files
find "$JAVA_SRC_DIR" -name '*.java' | xargs javac -d "$JAVA_OUT"

# Find all Java files with native methods
find "$JAVA_SRC_DIR" -name '*.java' | while read -r JAVA_FILE; do
    if grep -q 'native ' "$JAVA_FILE"; then
        # Get fully qualified class name
        REL_PATH="${JAVA_FILE#$JAVA_SRC_DIR/}"
        CLASS_NAME="${REL_PATH%.java}"
        FQCN="${CLASS_NAME//\//.}"
        HEADER_NAME="${CLASS_NAME//\//_}.h"
        HEADER_PATH="$HEADER_OUT/$HEADER_NAME"
        C_PATH="$JNI_OUT/$(basename "$CLASS_NAME").c"

        # Generate header if it doesn't exist
        if [ ! -f "$HEADER_PATH" ]; then
            javac -h "$HEADER_OUT" -d "$JAVA_OUT" "$JAVA_FILE"
        fi

        # Generate C stub if it doesn't exist
        if [ ! -f "$C_PATH" ]; then
            echo "#include \"$HEADER_NAME\"" > "$C_PATH"
            echo "" >> "$C_PATH"
            grep 'JNIEXPORT' "$HEADER_PATH" | sed 's/;$/ {\n    \/\/ TODO: implement\n}\n/' >> "$C_PATH"
        fi
    fi
done

echo "JNI header files generated in: $HEADER_OUT"
echo "JNI C stub files generated in: $JNI_OUT" 

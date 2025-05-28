#!/bin/bash
set -e

# Load common environment variables
source "$(dirname "$0")/env/variables.sh"

# Clean previous build
scripts/clean.sh

# Ensure JNI headers and stubs are generated
scripts/gen_jni.sh

JAVA_OUT=build/classes
JNI_OUT=src/main/jni
LIB_OUT=build/lib
HEADER_OUT=build/headers
PACKAGE=com.attafitamim.demo.jni.calculator
OUTPUT_DIR=build/output
JAR_NAME=calculator-demo.jar
MANIFEST=MANIFEST.MF
MAIN_CLASS=$PACKAGE.Main


# Detect platform and set native library extension and Java include paths
echo "Detecting operating system..."
UNAME_OUT="$(uname -s)"
JAVA_HOME_PATH="$(/usr/libexec/java_home)"
JAVA_INCLUDE="$JAVA_HOME_PATH/include"
case "$UNAME_OUT" in
    Darwin*)    LIB_EXT="dylib"; JAVA_PLATFORM_INCLUDE="$JAVA_HOME_PATH/include/darwin";;
    Linux*)     LIB_EXT="so"; JAVA_PLATFORM_INCLUDE="$JAVA_HOME_PATH/include/linux";;
    CYGWIN*|MINGW*|MSYS*) LIB_EXT="dll"; JAVA_PLATFORM_INCLUDE="$JAVA_HOME_PATH/include/win32";;
    *)          LIB_EXT="so"; JAVA_PLATFORM_INCLUDE="$JAVA_HOME_PATH/include";;
esac
LIB_NAME="libcalculator.$LIB_EXT"
mkdir -p $LIB_OUT $OUTPUT_DIR
echo "Operating system detected: $UNAME_OUT"

# Compile native code
echo "Compiling native (C) code for JNI..."
gcc -dynamiclib -I"$JAVA_INCLUDE" -I"$JAVA_PLATFORM_INCLUDE" -I$HEADER_OUT \
    -o $LIB_OUT/$LIB_NAME $JNI_OUT/Calculator.c

echo "Native library compiled: $LIB_OUT/$LIB_NAME"

# Compile Java (again, in case of changes)
echo "Compiling Java source files..."
javac -d $JAVA_OUT src/main/java/com/attafitamim/demo/jni/calculator/*.java
echo "Java classes compiled: $JAVA_OUT"

# Copy native library to output directory
cp "$LIB_OUT/$LIB_NAME" "$OUTPUT_DIR/"

# Create manifest for runnable jar
echo "Generating JAR manifest: $MANIFEST"
echo "Main-Class: $MAIN_CLASS" > $OUTPUT_DIR/$MANIFEST
echo "Native-Library-Path: ." >> $OUTPUT_DIR/$MANIFEST
echo "Manifest created at: $OUTPUT_DIR/$MANIFEST"

# Package application into JAR (Java classes only)
echo "Packaging application into JAR: $JAR_NAME"
jar cfm $OUTPUT_DIR/$JAR_NAME $OUTPUT_DIR/$MANIFEST -C $JAVA_OUT .
echo "JAR successfully created at: $OUTPUT_DIR/$JAR_NAME"

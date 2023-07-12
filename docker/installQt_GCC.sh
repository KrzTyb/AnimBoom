#!/bin/sh -xe

# Update packages
apt update

# Install AQT tool
pip3 install --no-cache-dir "aqtinstall==$AQT_VERSION"

# Install Qt
aqt install-qt -O "$QT_PATH" linux desktop "$QT_VERSION" gcc_64
aqt install-tool -O "$QT_PATH" linux desktop tools_cmake
aqt install-tool -O "$QT_PATH" linux desktop tools_ninja

# Cleanup
rm -rf /var/lib/apt/lists/*

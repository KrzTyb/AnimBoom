#!/bin/sh -xe

PRE_COMMIT_VERSION="3.3.3"

# Update packages
apt update

# Install packages
apt install -y $PACKAGES

# Install python packages
pip3 install --no-cache-dir "pre-commit==$PRE_COMMIT_VERSION"

# Cleanup
rm -rf /var/lib/apt/lists/*

#!/bin/sh -xe

# Update packages
apt update

# Install packages
apt install -y --no-install-suggests --no-install-recommends $PACKAGES

# Cleanup
rm -rf /var/lib/apt/lists/*

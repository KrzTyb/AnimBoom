#!/bin/sh -xe

# Update packages
apt update

# Install packages
apt install -y $PACKAGES

# Cleanup
rm -rf /var/lib/apt/lists/*

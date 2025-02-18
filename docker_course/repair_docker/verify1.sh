#!/bin/bash
# Check if Docker socket is active
if systemctl is-active --quiet docker.socket; then
    echo "Docker socket is active."
    exit 0
else
    echo "Docker socket is not active."
    exit 1
fi
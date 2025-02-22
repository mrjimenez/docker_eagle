#! /bin/bash

# The Eagle binary installation file.
#
# Make sure this file or a hard link to it is in the same
# directory as this script.
EAGLE_BIN=eagle.bin

# Build the docker image
docker build \
        --debug \
        --build-arg EAGLE_BIN="${EAGLE_BIN}" \
        -f Dockerfile \
        -t eagle:6.6.0.0 \
        .

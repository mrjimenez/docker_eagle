#! /bin/bash

# The Eagle binary installation file.
#
# Make sure this file or a hard link to it is in the same
# directory as this script.
#EAGLE_BIN=eagle.bin
#        --build-arg EAGLE_BIN="${EAGLE_BIN}" \

# A copy of the Eagle directory as installed in the host.
EAGLE_DIR=eagle-6.6.0

# Build the docker image
docker build \
        --debug \
        --build-arg EAGLE_DIR="${EAGLE_DIR}" \
        -f Dockerfile \
        -t eagle:6.6.0.0 \
        .

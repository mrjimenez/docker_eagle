#! /bin/bash

# The Eagle version.
EAGLE_VERSION=6.6.0

# The Eagle binary installation file.
#
# Make sure this file or a hard link to it is in the same
# directory as this script.
EAGLE_RUN_FILE=eagle-lin-"${EAGLE_VERSION}".run

# Build the docker image
docker build \
        --debug \
        --build-arg EAGLE_VERSION="${EAGLE_VERSION}" \
        --build-arg EAGLE_RUN_FILE="${EAGLE_RUN_FILE}" \
        -f Dockerfile \
        -t eagle:${EAGLE_VERSION} \
        .

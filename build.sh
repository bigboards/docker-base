#!/bin/bash

# Fail on error
set -e

DOCKER_DIR="."
ARCH=$(uname -m)
DOCKER="/usr/bin/docker"
VERSION="latest"

sed -i -- "s/__arch__/${ARCH}/g" ${DOCKER_DIR}/base-${ARCH}/Dockerfile

echo "Logging into the docker hub"
${DOCKER} login

IMAGE_NAME="$1/base-${ARCH}:${VERSION}"

echo "Building ${IMAGE_NAME}"
sudo -E ${DOCKER} build -t ${IMAGE_NAME} ${DOCKER_DIR}/base-${ARCH}

echo "Pushing ${IMAGE_NAME}"
sudo -E ${DOCKER} push ${IMAGE_NAME}


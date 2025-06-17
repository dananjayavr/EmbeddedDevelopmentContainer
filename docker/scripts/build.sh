#!/bin/bash
set -e

# Absolute path to the directory containing the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DIR="${SCRIPT_DIR}/.."

docker build \
  --file "${DOCKER_DIR}/Dockerfile" \
  --build-arg HOST_UID=$(id -u) \
  --build-arg HOST_GID=$(id -g) \
  -t ceedling-container \
  "${DOCKER_DIR}"

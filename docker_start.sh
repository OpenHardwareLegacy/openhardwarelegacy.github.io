#!/bin/bash

# Check if Docker is installed
if command -v docker &> /dev/null; then
    CONTAINER_TOOL="docker"
    ARGS="--privileged"
# Check if Podman is installed
elif command -v podman &> /dev/null; then
    CONTAINER_TOOL="podman"
    ARGS="--group-add keep-groups --security-opt label=disable"
else
    echo "Neither Docker nor Podman found. Please install one of them to proceed."
    exit 1
fi

$CONTAINER_TOOL run $ARGS --rm -it \
  -p 4000:4000 -p 35729:35729 \
  -v $(pwd):/srv/jekyll \
  my-jekyll \
  bundle exec jekyll serve --host 0.0.0.0 --livereload

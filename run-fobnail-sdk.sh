#!/usr/bin/env bash

# CI job fails if interactive mode is enabled
CI="${CI:-false}"
if [ "$CI" = "true" ]; then
  _tty_opts=""
else
  _tty_opts="-it"
fi

docker run --privileged \
    --rm "$_tty_opts" \
    -v /dev:/dev \
    -v $PWD:/build \
    -w /build \
    -e FOBNAIL_LOG=${FOBNAIL_LOG} \
    -e RUSTFLAGS="${RUSTFLAGS}" \
    -e USER_ID="$(id -u)" \
    -e GROUP_ID="$(id -g)" \
    -e CARGO_HOME="/home/builder/.cargo" \
    -e LLVM_CONFIG_PATH="/usr/bin/llvm-config-7" \
    -e LIBCLANG_PATH="/usr/lib/llvm-7/lib" \
    ${FOBNAIL_SDK_DOCKER_EXTRA_OPTS} \
    --net=host \
    --init \
    3mdeb/fobnail-sdk "$@"

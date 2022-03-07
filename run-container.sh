#!/usr/bin/env bash

dir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

docker run --privileged \
    --rm -it \
    -v $dir:/home/build/nrf-hal \
    -v /dev:/dev \
    -w /home/build/nrf-hal \
    3mdeb/fobnail-sdk /bin/bash

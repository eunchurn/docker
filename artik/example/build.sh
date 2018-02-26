#!/bin/bash

export ARXC_IMAGE=ksachdeva17/artik-cc-710

./arxc710 cmake -DCMAKE_TOOLCHAIN_FILE=/arxc/cmake-toolchains/toolchain-710.cmake -H. -Bbuild
./arxc710 cmake --build build
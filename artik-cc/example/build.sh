#!/bin/bash

export ARM64XC_IMAGE=ksachdeva17/artik-cc.710.base

./arm64xc cmake -DCMAKE_TOOLCHAIN_FILE=/arm64xc/cmake-toolchains/toolchain-710.cmake -H. -Bbuild
./arm64xc cmake --build build
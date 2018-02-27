#!/bin/bash

: ${ARM64BASE_IMAGE:=ksachdeva17/arm64-cc.base}

docker build -t $ARM64BASE_IMAGE .
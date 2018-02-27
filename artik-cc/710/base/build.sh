#!/bin/bash

: ${ARXC_IMAGE:=ksachdeva17/artik-cc.710.base}

docker build -t $ARXC_IMAGE .
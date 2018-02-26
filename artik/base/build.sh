#!/bin/bash

: ${ARXC_IMAGE:=ksachdeva17/artik-cc-base}

docker build -t $ARXC_IMAGE .
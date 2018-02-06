FROM ubuntu:16.04

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --fix-missing \
    build-essential \
    cmake \    
    git \
    wget \
    curl \
    pkg-config \
    libx11-dev \
    libpng-dev \
    software-properties-common \
    libatlas-base-dev \
    libgtk-3-dev \
    zip \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN wget http://dlib.net/files/dlib-19.9.tar.bz2
RUN tar xvf dlib-19.9.tar.bz2
RUN cd dlib-19.9 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && cmake --build . --config Release \
    && make install

RUN ldconfig



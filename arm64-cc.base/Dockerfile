FROM debian:stretch

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
    && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure apt-utils \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    pkg-config \    
    software-properties-common \    
    zip \
    wget \
    automake \
    cmake \
    curl \
    fakeroot \    
    git \
    make \
    runit \
    sudo \
    xz-utils

ENV HOST=aarch64-linux-gnu \
    TOOLCHAIN=gcc-linaro-aarch64-linux-gnu \    
    ARM64XC_ROOT=/arm64xc    

WORKDIR $ARM64XC_ROOT

RUN wget https://releases.linaro.org/components/toolchain/binaries/latest-5/aarch64-linux-gnu/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu.tar.xz \
    && tar -xvf gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu.tar.xz \
    && mv gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu $TOOLCHAIN

ENV ARCH=aarch64 \
    CROSS_COMPILE=$ARM64XC_ROOT/$TOOLCHAIN/bin/$HOST- \
    PATH=$ARM64XC_ROOT/$TOOLCHAIN/bin:$PATH 

COPY image/ /

WORKDIR /build
ENTRYPOINT [ "/arm64xc/entrypoint.sh" ] 

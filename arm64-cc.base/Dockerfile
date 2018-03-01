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
    curl \
    fakeroot \    
    git \
    make \
    runit \
    sudo \
    xz-utils

RUN mkdir -p /temp
WORKDIR /temp

RUN wget --progress=bar:force https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.sh -O cmake-install.sh
RUN chmod +x cmake-install.sh
RUN ./cmake-install.sh --skip-license --prefix=/usr

ENV HOST=aarch64-linux-gnu
ENV TOOLCHAIN=gcc-linaro-aarch64-linux-gnu
ENV ARM64XC_ROOT=/arm64xc    

WORKDIR $ARM64XC_ROOT

RUN wget https://releases.linaro.org/components/toolchain/binaries/6.4-2017.11/aarch64-linux-gnu/gcc-linaro-6.4.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz \
    && tar -xvf gcc-linaro-6.4.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz \
    && mv gcc-linaro-6.4.1-2017.11-x86_64_aarch64-linux-gnu $TOOLCHAIN

ENV ARCH=aarch64
ENV CROSS_COMPILE=$ARM64XC_ROOT/$TOOLCHAIN/bin/$HOST-
ENV PATH=$ARM64XC_ROOT/$TOOLCHAIN/bin:$PATH 

COPY image/ /

WORKDIR /build
ENTRYPOINT [ "/arm64xc/entrypoint.sh" ] 

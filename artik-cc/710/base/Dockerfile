FROM ksachdeva17/arm64-cc.base:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

COPY image/ /

ENV SYSROOT=$ARM64XC_ROOT/sysroot 
ENV QEMU_PATH=/usr/bin/qemu-aarch64-static
ENV QEMU_EXECVE=1

WORKDIR $SYSROOT

RUN wget https://github.com/SamsungARTIK/ubuntu-build-service/releases/download/release%2FA710_os_3.1.0/ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz \
    && tar -xvzf ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz -C . \
    && rm ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz \        
    && mkdir -p $SYSROOT/build 

# Below is the commented code for testing purposes
# as downloading the zip takes long time
# COPY ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz .
# RUN tar -xvzf ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz -C . \
#     && rm ubuntu-arm-artik710-rootfs-0710GC0F-44U-01Q3-20171113.171659-d159d7ed4107f1a6124c7937c24327aa.tar.gz \    
#     && mkdir -p $SYSROOT/build 

COPY qemu-aarch64-static $SYSROOT/$QEMU_PATH
RUN chmod +x $SYSROOT/$QEMU_PATH

COPY resolv.conf $SYSROOT/etc/.

RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c '\
    echo "deb http://repo.artik.cloud/artik/bin/pub/artik/ubuntu xenial main" > /etc/apt/sources.list.d/artik-e2e-sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 55955AEB \    
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y'

RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c '\
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
    && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure apt-utils \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    symlinks \
    && symlinks -cors /'

RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c '\
    DEBIAN_FRONTEND=noninteractive apt install -y libartik-sdk-dev \
    && DEBIAN_FRONTEND=noninteractive apt install -y zlib1g-dev \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev'  

RUN cp -rf $SYSROOT/usr/lib/aarch64-linux-gnu/pkgconfig/* $SYSROOT/usr/lib/pkgconfig

# Fix symlinks
RUN fixsymlinks $SYSROOT

# Copy the toolchain file
RUN mkdir -p $ARM64XC_ROOT/cmake-toolchains
WORKDIR $ARM64XC_ROOT/cmake-toolchains
COPY toolchain-710.cmake .

# setup the working directory to build
WORKDIR /build
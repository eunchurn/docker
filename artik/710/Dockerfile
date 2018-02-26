FROM ksachdeva17/artik-cc-base:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

ENV SYSROOT=$ARXC_ROOT/sysroot

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

RUN mkdir -p $ARXC_ROOT/cmake-toolchains

# Copy the toolchain file
WORKDIR $ARXC_ROOT/cmake-toolchains
COPY toolchain-710.cmake .

# setup the working directory to build
WORKDIR /build
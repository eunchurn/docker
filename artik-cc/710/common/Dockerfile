FROM ksachdeva17/artik-cc.710.base:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

# Install most of the common libraries 
# used for development
RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c '\
    DEBIAN_FRONTEND=noninteractive apt-get install -y libleveldb-dev'  

RUN mkdir -p $ARM64XC/temp
WORKDIR $ARM64XC/temp

# Install Boost
RUN wget https://sourceforge.net/projects/boost/files/boost/1.66.0/boost_1_66_0.tar.bz2
RUN tar xjf boost_1_66_0.tar.bz2
RUN cd boost_1_66_0 \
    && ./bootstrap.sh \
    && echo "using gcc : arm : /arm64xc/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ ;" > ~/user-config.jam \
    && ./b2 --no-samples --no-tests toolset=gcc-arm link=static,shared cxxflags=-fPIC \
    && ./b2 install --prefix=/arm64xc/sysroot 


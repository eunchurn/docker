FROM ksachdeva17/artik-cc.710.base:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

RUN mkdir -p $ARM64XC/temp
WORKDIR $ARM64XC/temp

# Install Boost
RUN wget https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.bz2
RUN tar xjf boost_1_66_0.tar.bz2
RUN cd boost_1_66_0 \
    && ./bootstrap.sh \
    && echo "using gcc : arm : /arm64xc/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ ;" > ~/user-config.jam \
    && ./b2 --no-samples --no-tests toolset=gcc-arm link=static,shared cxxflags=-fPIC -j4 install --prefix=/arm64xc/sysroot/usr 

WORKDIR $ARM64XC/temp

# Host part
RUN wget https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-cpp-3.5.1.tar.gz
RUN tar xvf protobuf-cpp-3.5.1.tar.gz
RUN mv protobuf-3.5.1 protobuf-3.5.1-host
WORKDIR $ARM64XC/temp/protobuf-3.5.1-host
RUN mkdir build
WORKDIR $ARM64XC/temp/protobuf-3.5.1-host/build
RUN cmake ../cmake
RUN	cmake --build .
RUN make install
RUN ldconfig

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    autoconf \
    automake \    
    curl \
    libtool

ENV CROSS_TRIPLE "aarch64-linux-gnu"
ENV PREFIX $ARM64XC_ROOT/$TOOLCHAIN/bin/$CROSS_TRIPLE

WORKDIR $ARM64XC/temp
RUN tar xvf protobuf-cpp-3.5.1.tar.gz
WORKDIR $ARM64XC/temp/protobuf-3.5.1
RUN ./autogen.sh
RUN ./configure --enable-shared=no --host=aarch64-linux CC=$PREFIX-gcc CXX=$PREFIX-g++ AR=$PREFIX-ar STRIP=$PREFIX-strip RANLIB=$PREFIX-ranlib --prefix=$SYSROOT/usr --with-protoc=protoc --with-pic
RUN make
RUN make install

RUN fixsymlinks $SYSROOT

# setup the working directory to build
WORKDIR /build
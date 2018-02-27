FROM ksachdeva17/artik-cc.710.common:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

RUN mkdir -p $ARM64XC/temp
WORKDIR $ARM64XC/temp

RUN wget http://dlib.net/files/dlib-19.9.tar.bz2
RUN tar xvf dlib-19.9.tar.bz2
RUN cd dlib-19.9 \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_TOOLCHAIN_FILE=/arm64xc/cmake-toolchains/toolchain-710.cmake .. \
    && cmake --build . --config Release \
    && make DESTDIR=/arm64xc/sysroot install


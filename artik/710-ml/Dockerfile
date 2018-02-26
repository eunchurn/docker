FROM ksachdeva17/artik-cc-710:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

RUN mkdir -p $ARXC/temp

WORKDIR $ARXC/temp

RUN wget http://dlib.net/files/dlib-19.9.tar.bz2
RUN tar xvf dlib-19.9.tar.bz2
RUN cd dlib-19.9 \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_TOOLCHAIN_FILE=/arxc/cmake-toolchains/toolchain-710.cmake .. \
    && cmake --build . --config Release \
    && make DESTDIR=/arxc/sysroot install


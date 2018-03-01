FROM ksachdeva17/artik-cc.710.common:latest

LABEL maintainer="Kapil Sachdeva <ksachdeva17@gmail.com>"

COPY toolchain-710ml.cmake $ARM64XC_ROOT/cmake-toolchains/.

RUN mkdir -p $ARM64XC_ROOT/temp
WORKDIR $ARM64XC_ROOT/temp

RUN wget http://dlib.net/files/dlib-19.9.tar.bz2
# COPY dlib-19.9.tar.bz2 .
RUN tar xvf dlib-19.9.tar.bz2 --exclude=dlib-19.9/docs
RUN cd dlib-19.9
RUN mkdir build 
WORKDIR $ARM64XC_ROOT/temp/dlib-19.9/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/arm64xc/cmake-toolchains/toolchain-710ml.cmake ..
RUN cmake --build . --config Release 
RUN make DESTDIR=/arm64xc/sysroot install

RUN wget https://github.com/google/leveldb/archive/v1.20.tar.gz
RUN tar xvf v1.20.tar.gz -C .
RUN cp -r leveldb-1.20 $SYSROOT/usr/src/.
RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c 'apt-get install -y build-essential'
RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c 'cd /usr/src/leveldb-1.20 && make out-static/libleveldb.a'
RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c 'cd /usr/src/leveldb-1.20 && cp out-static/lib* /usr/local/lib'
RUN chroot $SYSROOT $QEMU_PATH /bin/sh -c 'cd /usr/src/leveldb-1.20 && cp -r include/leveldb /usr/local/include'

RUN mkdir -p $ARM64XC_ROOT/temp
WORKDIR $ARM64XC_ROOT/temp
RUN wget https://raw.githubusercontent.com/alpqr/fixsymlinks_tx1/master/fixsymlinks.sh
RUN chmod +x fixsymlinks.sh
RUN ./fixsymlinks.sh $SYSROOT

WORKDIR /build
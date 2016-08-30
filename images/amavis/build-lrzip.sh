#!/bin/sh

set -e
BUILD_DIR=/tmp/lrzip
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget https://github.com/ckolivas/lrzip/archive/v$LRZIP_VER.tar.gz
tar -xzf v$LRZIP_VER.tar.gz

cd lrzip-$LRZIP_VER
./autogen.sh
./configure --enable-static-bin
make

mkdir -p $BUILD_DIR/result/usr
make prefix=$BUILD_DIR/result/usr install

mv $BUILD_DIR/* /out/

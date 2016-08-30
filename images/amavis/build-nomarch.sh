#!/bin/sh

set -e
BUILD_DIR=/tmp/nomarch
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget http://www.ibiblio.org/pub/Linux/utils/compress/nomarch-$NOMARCH_VER.tar.gz
tar -xzf nomarch-$NOMARCH_VER.tar.gz

cd nomarch-$NOMARCH_VER
make

mkdir -p $BUILD_DIR/result/usr
make PREFIX=$BUILD_DIR/result/usr install

mkdir -p $BUILD_DIR/result/usr/share/doc/nomarch
cp -f ./COPYING ./ChangeLog ./NEWS ./README \
      $BUILD_DIR/result/usr/share/doc/nomarch/

mv $BUILD_DIR/* /out/

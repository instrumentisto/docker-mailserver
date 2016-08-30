#!/bin/sh

set -e
BUILD_DIR=/tmp/ripole
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget http://www.pldaniels.com/ripole/ripole-$RIPOLE_VER.tar.gz
tar -xzf ripole-$RIPOLE_VER.tar.gz

cd ripole-$RIPOLE_VER
make

mkdir -p $BUILD_DIR/result/usr/bin
cp -f ./ripole \
      $BUILD_DIR/result/usr/bin/

mkdir -p $BUILD_DIR/result/usr/share/doc/ripole
cp -f ./LICENSE ./CONTRIBUTORS ./CHANGELOG ./README \
      $BUILD_DIR/result/usr/share/doc/ripole/

mv $BUILD_DIR/* /out/

#!/bin/sh

set -e
BUILD_DIR=/tmp/zoo
ZOO_ORG_VER=${ZOO_VER%-*}
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget http://http.debian.net/debian/pool/main/z/zoo/zoo_$ZOO_ORG_VER.orig.tar.gz
tar -xzf zoo_$ZOO_ORG_VER.orig.tar.gz
wget http://http.debian.net/debian/pool/main/z/zoo/zoo_$ZOO_VER.debian.tar.gz
tar -xzf zoo_$ZOO_VER.debian.tar.gz

cd zoo-$ZOO_ORG_VER.orig/
for patchFile in ../debian/patches/*.patch; do
    patch < $patchFile
done
make linux

mkdir -p $BUILD_DIR/result/usr/bin
cp -f ./zoo ./fiz \
      $BUILD_DIR/result/usr/bin/

mkdir -p $BUILD_DIR/result/usr/share/man/man1
cp -f ./*.1 \
      $BUILD_DIR/result/usr/share/man/man1/

mkdir -p $BUILD_DIR/result/usr/share/doc/zoo
cd ../debian
cp -f ./copyright ./changelog \
      $BUILD_DIR/result/usr/share/doc/zoo/

mv $BUILD_DIR/* /out/

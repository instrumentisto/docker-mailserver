#!/bin/sh

set -e
BUILD_DIR=/tmp/freeze
FREEZE_ORG_VER=${FREEZE_VER%-*}
set -x

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget http://dl.fedoraproject.org/pub/epel/7/SRPMS/f/freeze-$FREEZE_VER.el7.src.rpm
7z x freeze-$FREEZE_VER.el7.src.rpm
cpio -F freeze-$FREEZE_VER.el7.src.cpio -i
tar -xzf freeze-$FREEZE_ORG_VER.tar.gz
cp /out/freeze-alpine-putc.patch ./

cd freeze-$FREEZE_ORG_VER/
for patchFile in ../*.patch; do
  patch < $patchFile
done
./configure
make

mkdir -p $BUILD_DIR/result/usr/bin
cp -f ./freeze ./statist \
      $BUILD_DIR/result/usr/bin/
for link in `echo "melt unfreeze fcat"`; do
  ln -s ./freeze $BUILD_DIR/result/usr/bin/$link
done

mkdir -p $BUILD_DIR/result/usr/share/doc/freeze
cp -f ./README \
      $BUILD_DIR/result/usr/share/doc/freeze/

mkdir -p $BUILD_DIR/result/usr/share/man/man1
cp -f ./freeze.1 ./statist.1 \
      $BUILD_DIR/result/usr/share/man/man1/
for link in `echo "melt unfreeze fcat"`; do
  ln -s ./freeze.1 $BUILD_DIR/result/usr/share/man/man1/$link.1
done

mv $BUILD_DIR/* /out/

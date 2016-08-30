#!/bin/sh

set -e
BUILD_DIR=/tmp/freeze
set -x

apk add --update p7zip

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget http://dl.fedoraproject.org/pub/epel/7/SRPMS/f/freeze-2.5.0-16.el7.src.rpm
7z x freeze-2.5.0-16.el7.src.rpm
cpio -F freeze-2.5.0-16.el7.src.cpio -i
tar -xzf freeze-2.5.0.tar.gz

cd freeze-2.5.0/
for patchFile in ../*.patch; do
    patch < $patchFile
done
./configure
#make

#mkdir -p $BUILD_DIR/result/usr
#make prefix=$BUILD_DIR/result/usr install

#mv $BUILD_DIR/* /out/

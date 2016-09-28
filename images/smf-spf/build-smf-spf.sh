#!/bin/sh

set -e
BUILD_DIR=/tmp/smf-spf
set -x

echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
      >> /etc/apk/repositories
apk add --update \
    libspf2-dev libmilter-dev@testing

mkdir -p $BUILD_DIR
cd $BUILD_DIR
wget https://github.com/jcbf/smf-spf/archive/v$SMFSPF_VER.tar.gz
tar -xzf v$SMFSPF_VER.tar.gz

cd smf-spf-$SMFSPF_VER
make

mkdir -p $BUILD_DIR/result/usr/bin
cp -f smf-spf \
      $BUILD_DIR/result/usr/bin/

mkdir -p $BUILD_DIR/result/usr/share/doc/smf-spf
cp -f LICENSE COPYING ChangeLog CHANGELOG.md readme README.md \
      $BUILD_DIR/result/usr/share/doc/smf-spf/

mv $BUILD_DIR/* /out/

#!/bin/sh

set -e
BUILD_DIR=/tmp/roundcube
RESULT_DIR=$BUILD_DIR/result/var/www
set -x

mkdir -p $RESULT_DIR
cd $BUILD_DIR
wget https://github.com/roundcube/roundcubemail/releases/download/$ROUNDCUBE_VER/roundcubemail-$ROUNDCUBE_VER.tar.gz
tar -xzf roundcubemail-$ROUNDCUBE_VER.tar.gz
# remove target directory for renaming not moving into
rm -rf $RESULT_DIR
mv roundcubemail-$ROUNDCUBE_VER $RESULT_DIR

cd $RESULT_DIR
mv composer.json-dist composer.json
composer install --no-dev --optimize-autoloader
rm -rf installer

mv $BUILD_DIR/* /out/

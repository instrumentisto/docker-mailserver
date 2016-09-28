#!/bin/sh

set -e
BUILD_DIR=/tmp/roundcube
RESULT_DIR=$BUILD_DIR/result/var/www
set -x

mkdir -p $RESULT_DIR
cd $RESULT_DIR
git clone https://github.com/roundcube/roundcubemail ./
git checkout tags/$ROUNDCUBE_VER

mv composer.json-dist composer.json
composer install --no-dev --optimize-autoloader

rm -rf .git .gitignore .tx installer Dockerfile

mv $BUILD_DIR/* /out/

#!/bin/sh

mkdir -p /var/opendkim
cp -rf /etc/dkim-config/* /var/opendkim/
chown -R opendkim:opendkim /var/opendkim

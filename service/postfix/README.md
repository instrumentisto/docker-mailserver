Postfix Docker image (SMTP server)
==================================

<img align="right" src="http://www.postfix.org/mysza.gif">
[![docker](https://img.shields.io/badge/docker-quay.io%2Finstrumentisto%2Fpostfix-green.svg)](https://quay.io/repository/instrumentisto/postfix)
[![based](https://img.shields.io/badge/based%20on-alpine%3A3.4-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)

Minimalistic Docker image of [Postfix SMTP server](http://www.postfix.org).



## Configuration

Provided with default configuration of Alpine Linux
[postfix package](https://pkgs.alpinelinux.org/packages?name=postfix).

To override default configuration you must provide your own configuration files
and mount them into `/etc/postfix/` directory of container.



## Logs

As far as `postfix` writes its logs only to `syslog`, the `syslog` of this image
is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/rsyslog.d/30-log.conf` file
with correspondent log rules.

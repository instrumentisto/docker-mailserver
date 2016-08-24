Postfix SMTP server Docker image
================================

[![docker](https://img.shields.io/badge/docker-quay.io%2Finstrumentisto%2Fpostfix-green.svg)](https://quay.io/repository/instrumentisto/postfix)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)

Based on [Alpine Linux image](https://hub.docker.com/_/alpine/).

Provided with default configuration of Alpine Linux
[postfix package](https://pkgs.alpinelinux.org/packages?name=postfix).
To override default configuration you must provide your own configuration files
and mount them into `/etc/postfix/` directory of container.

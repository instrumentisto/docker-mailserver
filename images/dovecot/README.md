Dovecot Docker image (IMAP and POP3 server) 
===========================================

<img align="right" src="http://dovecot.org/dovecot.gif">
[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fdovecot-green.svg)](https://quay.io/repository/instrumentisto/dovecot)
[![based](https://img.shields.io/badge/based%20on-alpine%3A3.4-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/dovecot)

Docker image of [Dovecot IMAP and POP3 server](http://dovecot.org).  
Contains pre-installed [Pigeonhole plugin](http://wiki2.dovecot.org/Pigeonhole/Sieve/Configuration)
for [Sieve filters](http://sieve.info) support.



## Configuration

Image is provided with default configuration of Alpine Linux
[dovecot package](https://pkgs.alpinelinux.org/packages?name=dovecot). The only
thing is changed is making all logging to `/dev/stdout` directly.

Just to override some parameters of default configuration the convenient way is 
to add file `/etc/dovecot/local.conf` with desired declarations.  
For more complex reconfiguration it can be better to add/replace drop-in files
in `/etc/dovecot/conf.d/` directory.

If you need to perform some additional jobs on container startup, you may
specify them in `/etc/cont-init.d/` directory (according to 
[s6-overlay conventions](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks)). 

Postfix Docker image (SMTP server)
==================================

<img align="right" src="http://www.postfix.org/mysza.gif">
[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fpostfix-green.svg)](https://quay.io/repository/instrumentisto/postfix)
[![based](https://img.shields.io/badge/based%20on-alpine%3A3.4-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/postfix)

Minimalistic Docker image of [Postfix SMTP server](http://www.postfix.org).



## Configuration

Provided with default configuration of Alpine Linux
[postfix package](https://pkgs.alpinelinux.org/packages?name=postfix).

There are two ways to override default configuration:
 
1.  Specify your own configuration files into `/etc/postfix/` directory.

2.  Overwrite existing configuration files in `/etc/postfix/` directory on
    container startup.
    This can be done (according to [s6-overlay conventions](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks))
    by specifying some files in `/etc/cont-init.d/` directory which will do 
    the stuff.  
    Example `/etc/cont-init.d/01-reconfigure-postfix`:
    ```bash
    #!/bin/sh
    sed -i -r 's/^#(debug_peer_list .*)$/\1/g' /etc/postfix/main.cf
    echo "content_filter = smtp-amavis:[127.0.0.1]:10024" >> /etc/postfix/main.cf
    ```




## Logs

As far as `postfix` writes its logs only to `syslog`, the `syslog` of this image
is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/syslog.conf` file
with desired log rules.

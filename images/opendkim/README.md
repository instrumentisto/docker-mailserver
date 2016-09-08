OpenDKIM Docker image (milter-based filter) 
============================================

[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fopendkim-green.svg)](https://quay.io/repository/instrumentisto/opendkim)
[![based](https://img.shields.io/badge/based%20on-alpine%3Aedge-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/opendkim)

Minimalistic Docker image of [OpenDKIM milter-based filter](http://www.opendkim.org).



## Configuration

Image is provided with the 
[following default configuration](https://github.com/instrumentisto/docker-mailserver/blob/master/images/opendkim/rootfs/etc/opendkim/opendkim.conf)
(performs only verifying).

There are two ways to override default configuration:
 
1.  Specify your own `/etc/opendkim/opendkim.conf` file with desired
    configuration. But this requires to specify full configuration which
    can be uncomfortable if you need just tune a couple of parameters.

2.  Specify `/etc/opendkim/opendkim.custom.conf` file with desired declarations
    to overwrite existing default configuration.



## Fixing files permissions

If there is need to change permissions of some files (mounted private keys,
i.e.) on container startup, the convenient way to do this will be specifying
`/etc/fix-attrs.d/` file(s)
[according to s6-overlay convention](https://github.com/just-containers/s6-overlay#fixing-ownership--permissions).

Example `/etc/fix-attrs.d/30-opendkim-data`:
```
/var/opendkim      true opendkim 0644 0755
/var/opendkim/keys true opendkim 0600 0755
```

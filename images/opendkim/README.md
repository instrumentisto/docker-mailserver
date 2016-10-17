OpenDKIM Docker image (DKIM milter) 
===================================

[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fopendkim-green.svg)](https://quay.io/repository/instrumentisto/opendkim)
[![based](https://img.shields.io/badge/based%20on-debian%3Astretch-blue.svg)](https://hub.docker.com/_/debian)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/opendkim)

Docker image of [OpenDKIM milter](http://www.opendkim.org) (mail filter).



## Configuration

Image is provided with the 
[following default configuration](https://github.com/instrumentisto/docker-mailserver/blob/master/images/opendkim/rootfs/etc/opendkim/opendkim.conf)
(performs only verifying).

There are two ways to override default configuration:
 
1.  Specify your own `/etc/opendkim/opendkim.conf` file with desired
    configuration. But this requires to specify full configuration which
    can be uncomfortable if you need just tune a couple of parameters.

2.  Specify `/etc/opendkim/conf.d/custom.conf` file with desired declarations
    to overwrite existing default configuration.



## Logs

As far as `opendkim` daemon can only log to `syslog`,
the `syslog` of this image is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/rsyslog.d/30-log.conf` file
with desired log rules.



## Fixing files permissions

If there is a need to change permissions of some files (mounted private keys,
i.e.) on container startup, the convenient way to do this will be specifying
`/etc/fix-attrs.d/` file(s)
[according to s6-overlay convention](https://github.com/just-containers/s6-overlay#fixing-ownership--permissions).

Example `/etc/fix-attrs.d/30-opendkim-data`:
```
/var/opendkim       true opendkim 0644 0755
/var/opendkim/keys  true opendkim 0600 0755
```

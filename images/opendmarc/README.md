OpenDMARC Docker image (milter-based filter) 
============================================

[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fopendmarc-green.svg)](https://quay.io/repository/instrumentisto/opendmarc)
[![based](https://img.shields.io/badge/based%20on-debian%3Ajessie-blue.svg)](https://hub.docker.com/_/debian)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/opendmarc)

Docker image of [OpenDMARC milter-based filter](http://www.trusteddomain.org/opendmarc)
implementation of the [DMARC specification](https://dmarc.org/).



## Configuration

Image is provided with the 
[following default configuration](https://github.com/instrumentisto/docker-mailserver/blob/master/images/opendkim/rootfs/etc/opendmarc.conf).

There are two ways to override default configuration:
 
1.  Specify your own `/etc/opendmarc.conf` file with desired
    configuration. But this requires to specify full configuration which
    can be uncomfortable if you need just tune a couple of parameters.

2.  Specify drop-in configuration files in `/etc/opendmarc.d/` directory
    which will be automatically append to the main configuration file
    on container startup.  
    Example `/etc/opendmarc.d/10-socket.conf`:
    ```
    Socket   inet:1234@127.0.0.1
    ```



## Logs

As far as `opendmarc` daemon can only log to `syslog`,
the `syslog` of this image is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/rsyslog.d/30-log.conf` file
with correspondent log rules.



## Fixing files permissions

If there is need to change permissions of some files (mounted files, i.e.) 
on container startup, the convenient way to do this will be specifying
`/etc/fix-attrs.d/` file(s)
[according to s6-overlay convention](https://github.com/just-containers/s6-overlay#fixing-ownership--permissions).

Example `/etc/fix-attrs.d/30-opendmarc-data`:
```
/var/opendmarc/history.dat  true opendkim 0644 0755
```

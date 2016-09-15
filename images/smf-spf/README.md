smf-spf Docker image (SPF milter) 
=================================

[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fsmf--spf-green.svg)](https://quay.io/repository/instrumentisto/smf-spf)
[![based](https://img.shields.io/badge/based%20on-alpine%3Aedge-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/smf-spf)

Docker image of [smf-spf SPF milter](https://github.com/jcbf/smf-spf) (mail filter).



## Configuration

Image is provided with the 
[following default configuration](https://github.com/instrumentisto/docker-mailserver/blob/master/images/smf-spf/rootfs/etc/smf-spf/smf-spf.conf).

There are two ways to override default configuration:
 
1.  Specify your own `/etc/smf-spf/smf-spf.conf` file with desired
    configuration. But this requires to specify full configuration which
    can be uncomfortable if you need just tune a couple of parameters.

2.  Specify drop-in configuration files in `/etc/smf-spf/conf.d/` directory
    which will be automatically append to the main configuration file
    on container startup.  
    Example `/etc/smf-spf/conf.d/10-socket.conf`:
    ```
    Socket   inet:1234@127.0.0.1
    ```



## Logs

As far as `smp-spf` daemon can only log to `syslog`,
the `syslog` of this image is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/syslog.conf` file
with desired log rules.

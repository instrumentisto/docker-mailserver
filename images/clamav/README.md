ClamAV Docker image 
===================

<img align="right" src="https://www.clamav.net/assets/clamav-trademark.png">
[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Fclamav-green.svg)](https://quay.io/repository/instrumentisto/clamav)
[![based](https://img.shields.io/badge/based%20on-alpine%3A3.4-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/clamav)

Minimalistic Docker image of [ClamAV mail antivirus](https://www.clamav.net).



## Configuration

Image is provided with default configuration of Alpine Linux
[clamav package](https://pkgs.alpinelinux.org/packages?name=clamav).
The few things changed are making `clamd` and `freshclam` daemons to run 
in foreground and disable any log rotations.

There are two ways to override default configuration:
 
1.  Specify your own `/etc/clamav/clamd.conf` and `/etc/clamav/freshclam.conf`
    files with desired configuration. But you must provide precise configuration
    which plays well with image layout: foreground daemons running, correct
    path to logpipe, etc. This can be painful and requires to dive into image
    layout.

2.  Overwrite existing `/etc/clamav/clamd.conf` and `/etc/clamav/freshclam.conf`
    files on container startup.
    This can be done (according to [s6-overlay conventions](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks))
    by specifying some files in `/etc/cont-init.d/` directory which will do 
    the stuff.  
    Example `/etc/cont-init.d/01-reconfigure-clamd`:
    ```bash
    #!/bin/sh
    sed -i -r 's/^#LogVerbose .*$/LogVerbose yes/g' /etc/clamav/clamd.conf
    ```



## Logs

By default `clamd` daemon writes its logs to `/var/log/clamav/clamd.log`
file. In this image this file is represented as
[logpipe](https://github.com/docker/docker/issues/6880#issuecomment-170214851)
which redirects all logs to `STDOUT`.

Log file of `freshclam` daemon is disabled at all, as far as this daemon prints
its logs directly to `STDOUT`.



## Sharing files

If you need to share files between this container and another one,
the best way to avoid permissions mess is to make those files accessible under
`nobody` group which is present in almost any container (so you don't need
to create some user/group explicitly).  
User `clamav` (which `clamd` runs as, by default) is already added to `nobody`
group in this image.

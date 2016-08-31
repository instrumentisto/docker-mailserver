AMaViS Docker image 
===================

<img align="right" width="200" src="http://amavis.sourceforge.net/images/amavis-2.png">
[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Famavis-green.svg)](https://quay.io/repository/instrumentisto/amavis)
[![based](https://img.shields.io/badge/based%20on-alpine%3A3.4-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/amavis)

Lightweight Docker image of [AMaViS amavisd-new interface](https://www.ijs.si/software/amavisd).



## Overview

Image is supposed to represent single `amavisd` process.  
However, there is no much of single `amavisd` in container. It requires and uses
some additional tools (already packed into image):

* [SpamAssassin](http://spamassassin.apache.org/)  
  SpamAssassin is required by `amavisd` for performing spam filtering.  
  It's important to note that `amavisd` uses SpamAssassin via perl API directly,
  so neither `spamd` running process, nor `spamassassin` 
  command-line application is required (see
  [details](http://mail-archives.apache.org/mod_mbox/spamassassin-users/201001.mbox/%3C4B43FA52.40401@verizon.net%3E)).
  
* [Razor](http://razor.sourceforge.net/)  
  Vipul's Razor spam detection and filtering network is used by SpamAssassin
  for better spam filtering.
  
Despite the fact that all tools listed above do not represent long-live
container processes, additional job is required to be done for container to
run a long time: updating SpamAssassin rules, Razor bases and etc.  
That's why image is packed with required cron jobs and container runs `crond`
and `rsyslogd` as additional processes.



## Configuration

### AMaViS
Image is provided with default configuration of Alpine Linux
[amavisd-new package](https://pkgs.alpinelinux.org/packages?name=amavisd-new).

There are two ways to override `amavisd` default configuration:

1.  Specify your own `/etc/amavis/amavisd.conf` configuration file.

2.  Specify drop-in configuration files in `/etc/amavis/conf.d/` directory
    which will override parameters of default configuration. These drop-in files
    must have `.conf` or `.cf` extension.

### SpamAssassin
Image is provided with default configuration of Alpine Linux
[spamassassin package](https://pkgs.alpinelinux.org/packages?name=spamassassin).
The only thing is added is `use_razor2 1` parameter.

There are two ways to override SpamAssassin default configuration:

1.  Specify your own configuration files in `/etc/mail/spamassassin/` directory.

2.  Overwrite existing files in `/etc/mail/spamassassin/` directory on container
    startup. This can be done (according to
    [s6-overlay conventions](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks))
    by specifying some files in `/etc/cont-init.d/` directory which will do 
    the stuff.  
    Example `/etc/cont-init.d/01-reconfigure-spamassassin`:
    ```bash
    #!/bin/sh
    sed -i -r 's/^(use_razor2.*)$/#\1/g' /etc/mail/spamassassin/local.cf
    ```

### Razor
Razor is configured at `/var/amavis/.razor` home directory.  
All logs are forwarded to container's `syslog`.  
Default logs verbosity is `5`.  
Default Razor `logic_method` is `5` (see [why](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=247057;msg=30)).

To override this configuration you can either specify your own
`/var/amavis/.razor/razor-agent.conf` or overwrite its parameters on container
startup (via `/etc/cont-init.d/` files according to
[s6-overlay conventions](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks))
.  
Example `/etc/cont-init.d/02-reconfigure-razor`:
```bash
#!/bin/sh
sed -i -r 's/^(logic_method[^=]*=).*$/\1 4/g' /var/amavis/.razor/razor-agent.conf
```



## Logs

As far as `amavisd` is unable to write logs normally to `STDOUT`, `/dev/stdout/`
or [logpipes](https://github.com/docker/docker/issues/6880#issuecomment-170214851)
(due to trying to perform `seek()`) its configured to write logs to `syslog`.  
For convenience, logs of `crond` and `razor-admin` also are forwarded to `syslog`.  
Logs of `sa-update`, however, are printed directly to `STDERR`.

The `syslog` of this image is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/rsyslog.d/30-log.conf` file
with correspondent log rules.

To disable `sa-update` logs you need to provide your own 
`/etc/periodic/daily/spamassassin-update` cron job with correct parameters.



## Troubleshooting

To avoid following error
```
  The value of variable $myhostname is "a81bd12ab229", but should have been
  a fully qualified domain name; perhaps uname(3) did not provide such.
  You must explicitly assign a FQDN of this host to variable $myhostname
  in amavisd.conf, or fix what uname(3) provides as a host's network name!
```
you must provide container's hostname FQDN while running it.  

This can be done via command line `--hostname` option:
```bash
docker run --rm -it --hostname=mail.example.com quay.io/instrumentisto/amavis
```

Or via `hostname` and `domainname` options in `docker-compose.yml` manifest:
```yaml
version: '2'
services:
  amavis:
    image: quay.io/instrumentisto/amavis
    hostname: mail
    domainname: example.com    
```  



## Archive decoders

Image is packed with almost all file decoders required by AMaViS.
```
amavis[174]: Internal decoder for .mail
amavis[174]: No ext program for   .F, tried: unfreeze, freeze -d, melt, fcat
amavis[174]: Found decoder for    .Z    at /usr/bin/uncompress
amavis[174]: Found decoder for    .gz   at /usr/bin/gzip -d
amavis[174]: Found decoder for    .bz2  at /usr/bin/bzip2 -d
amavis[174]: Found decoder for    .xz   at /usr/bin/unxz -c
amavis[174]: Found decoder for    .lzma at /usr/bin/lzma -dc
amavis[174]: Found decoder for    .lrz  at /usr/bin/lrzip -q -k -d -o -
amavis[174]: Found decoder for    .lzo  at /bin/lzop -d
amavis[174]: Found decoder for    .lz4  at /usr/bin/lz4c -d
amavis[174]: No ext program for   .rpm, tried: rpm2cpio.pl, rpm2cpio
amavis[174]: Found decoder for    .cpio at /bin/cpio
amavis[174]: Found decoder for    .tar  at /bin/cpio
amavis[174]: No ext program for   .deb, tried: ar
amavis[174]: Found decoder for    .rar  at /usr/bin/unrar
amavis[174]: Found decoder for    .arj  at /usr/bin/unarj
amavis[174]: Found decoder for    .arc  at /usr/bin/nomarch
amavis[174]: Found decoder for    .zoo  at /usr/bin/zoo
amavis[174]: Found decoder for    .doc  at /usr/bin/ripole
amavis[174]: Found decoder for    .cab  at /usr/bin/cabextract
amavis[174]: No ext program for   .tnef, tried: tnef
amavis[174]: Internal decoder for .tnef
amavis[174]: Found decoder for    .zip  at /usr/bin/7za
amavis[174]: Found decoder for    .kmz  at /usr/bin/7za
amavis[174]: Found decoder for    .7z   at /usr/bin/7zr
amavis[174]: Found decoder for    .jar  at /usr/bin/7z
amavis[174]: Found decoder for    .swf  at /usr/bin/7z
amavis[174]: Found decoder for    .lha  at /usr/bin/7z
amavis[174]: Found decoder for    .iso  at /usr/bin/7z
amavis[174]: Found decoder for    .deb  at /usr/bin/7z
amavis[174]: Found decoder for    .rpm  at /usr/bin/7z
amavis[174]: Found decoder for    .exe  at /usr/bin/unrar; /usr/bin/unarj
amavis[174]: No decoder for       .F
```

Decoder for `.F` files will be added 
[as soon as possible](https://github.com/instrumentisto/docker-mailserver/issues/1).
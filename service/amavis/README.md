AMaViS Docker image 
===================

<img align="right" width="200" src="http://amavis.sourceforge.net/images/amavis-2.png">
[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Famavis-green.svg)](https://quay.io/repository/instrumentisto/amavis)
[![based](https://img.shields.io/badge/based%20on-alpine%3A3.4-blue.svg)](https://hub.docker.com/_/alpine)
[![uses](https://img.shields.io/badge/uses-s6--overlay-blue.svg)](https://github.com/just-containers/s6-overlay)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)

Minimalistic Docker image of [AMaViS amavisd-new interface](https://www.ijs.si/software/amavisd).



## Configuration

Image is provided with default configuration of Alpine Linux
[amavisd-new package](https://pkgs.alpinelinux.org/packages?name=amavisd-new).

To override default configuration you can either specify your own 
`/etc/amavisd.conf` file or just add file `/etc/amavisd-custom.conf`
with desired declarations.



## Logs

As far as `amavisd` is unable to write logs normally to `STDOUT`, `/dev/stdout/`
or [logpipes](https://github.com/docker/docker/issues/6880#issuecomment-170214851),
the `syslog` of this image is configured to write everything to `/dev/stdout`.  
To change this behaviour just provide your own `/etc/rsyslog.d/30-log.conf` file
with correspondent log rules.



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

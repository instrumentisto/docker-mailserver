Roundcube webmail Docker image
==============================

<img align="right" src="https://roundcube.net/images/logo.png">
[![docker](https://img.shields.io/badge/image-quay.io%2Finstrumentisto%2Froundcube-green.svg)](https://quay.io/repository/instrumentisto/roundcube)
[![based](https://img.shields.io/badge/based%20on-php%3A7.0.11--fpm--alpine-blue.svg)](https://hub.docker.com/_/php)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/instrumentisto/docker-mailserver/blob/master/LICENSE.md)
[![github](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/instrumentisto/docker-mailserver/tree/master/images/roundcube)

Docker image of [Roundcube webmail](https://roundcube.net).



## Usage

This image represents `php-fpm` based solution for serving Roundcube Webmail.
It is intended to be used as FastCGI backend for web server, so cannot be used
alone and requires web server to run.

`php-fpm` daemon inside image is set to run as `nobody` user instead of
default `www-data` user (of `php:alpine` image) to simplify integration with
other containers which in most cases do not have `www-data` user.

Example of usage with [Nginx webserver](http://nginx.org) can be described
with following `docker-compose.yml`:
```yaml
version: '2'
services:
  roundcube:
    image: quay.io/instrumentisto/roundcube
    expose:
      - "9000"
    volumes:
      - /var/www
      - ./roundcube.config.php:/var/www/config/config.inc.php:ro  
  nginx:
    image: nginx:stable-alpine
    # Make sure that Nginx will run workers under "nobody" user.
    command: /bin/sh -c "sed -i -r 's/^user .*$$/user nobody;/g'
                             /etc/nginx/nginx.conf
                         && nginx -g 'daemon off;'"
    depends_on:
      - roundcube
    ports:
      - "80:80"
    volumes:
      - ./nginx.roundcube.conf:/etc/nginx/conf.d/default.conf:ro
    volumes_from:
      - roundcube:ro
```
Where `nginx.roundcube.conf` may be defined as following:
```
server {
    listen       80;
    root   /var/www/html;
    index  index.php index.html;
    location ~ ^/.+\.php(/|$) {
        fastcgi_pass   roundcube:9000;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        fastcgi_index  index.php;
        include        fastcgi_params;
    }
}
```



## Configuration

To override [default Roundcube configuration](https://github.com/roundcube/roundcubemail/blob/1.2.1/config/defaults.inc.php)
you need to specify your own `/var/www/config/config.inc.php` configuration
file with declarations which will override default values.

Also, this image contains prepared directory for SQLite database (if you choose
to use one) in `/var/db/` path. So your `db_dsnw` parameter is preferred to have
following value:
```php
$config['db_dsnw'] = 'sqlite:////var/db/roundcube.db?mode=0640';
```

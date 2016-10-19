FROM php:7.0.12-fpm-alpine


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN apk add --update --no-cache \
        ca-certificates \
        libpq \
        aspell-libs \
 && apk add --no-cache --virtual .tools-deps \
        autoconf g++ libtool make \
 && apk add --no-cache --virtual .build-deps \
        zlib-dev \
        postgresql-dev \
        aspell-dev \
 && docker-php-ext-install \
           opcache \
           pdo_pgsql pdo_mysql \
           pspell \
 && pecl install \
         zip \
 && docker-php-ext-enable \
           zip \
 && apk del .tools-deps .build-deps \
 && rm -rf /var/cache/apk/*


COPY rootfs /

RUN chmod +x /etc/services.d/*/run \

 # Prepare project directory
 && rm -rf /var/www/html \
 && mv /var/www/public_html /var/www/html \
 && chown -R nobody:nobody /var/www \

 # Prepare directory for SQLite database
 && mkdir -p /var/db \
 && chown -R nobody:nobody /var/db \

 # Make default configuration log to syslog
 && sed -i -r 's/^([^\s]{9}log_driver[^\s]{2} =) [^\s]+$/\1 "syslog";/g' \
        /var/www/config/defaults.inc.php


ENTRYPOINT ["/init"]

CMD ["php-fpm"]

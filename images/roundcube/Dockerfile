FROM php:7.0.11-fpm-alpine


RUN apk add --update --no-cache \
        tini \
        ca-certificates \
 && docker-php-ext-install \
           opcache \
 && rm -rf /var/cache/apk/*


COPY rootfs /

RUN rm -rf /var/www/html \
 && mv /var/www/public_html /var/www/html \
 && chown -R nobody:nobody /var/www \

 # Prepare directory for SQLite database
 && mkdir -p /var/db \
 && chown -R nobody:nobody /var/db


ENTRYPOINT ["/sbin/tini", "--"]

CMD ["php-fpm"]

FROM alpine:3.4


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN apk add --update --no-cache \
        dovecot=2.2.24-r1 \
 && rm -rf /var/cache/apk/* \

 && sed -i -r 's/^#log_path = syslog$/log_path = \/dev\/stdout/g' /etc/dovecot/conf.d/10-logging.conf


COPY rootfs /


EXPOSE 143 993 110 995


ENTRYPOINT ["/init"]

CMD ["/usr/sbin/dovecot", "-F"]

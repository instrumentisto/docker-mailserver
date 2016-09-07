FROM alpine:edge


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
      >> /etc/apk/repositories \
 && apk add --update --no-cache \
        rsyslog \
        opendkim@testing=2.10.3-r2 \
 && rm -rf /var/cache/apk/*


COPY rootfs /

RUN chmod +x /etc/services.d/*/run \

 && mkdir -p /run/opendkim \
 && chown -R opendkim:opendkim /run/opendkim


EXPOSE 12301


ENTRYPOINT ["/init"]

CMD ["opendkim", "-f", "-x", "/etc/opendkim/opendkim.conf"]

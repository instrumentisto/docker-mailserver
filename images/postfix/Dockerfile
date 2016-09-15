FROM alpine:3.4


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN apk add --update --no-cache \
        ca-certificates \
        postfix=3.1.1-r0 \
 && rm -rf /var/cache/apk/*


COPY rootfs /

RUN chmod +x /etc/services.d/*/run


EXPOSE 25 465 587


ENTRYPOINT ["/init"]

CMD ["/usr/lib/postfix/master", "-d"]

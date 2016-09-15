FROM debian:stretch


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        rsyslog \
        opendmarc=1.3.1+dfsg-4 \
 && rm -rf /var/lib/apt/lists/*


COPY rootfs /

RUN chmod +x /etc/services.d/*/run \

 && mkdir -p /run/opendmarc \
 && chown -R opendmarc:opendmarc /run/opendmarc


EXPOSE 8893


ENTRYPOINT ["/init"]

CMD ["opendmarc", "-f", "-c", "/etc/opendmarc.merged.conf"]

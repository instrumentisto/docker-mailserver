FROM debian:stretch


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN mkdir -p /tmp/s6-overlay/ \
 && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /tmp/s6-overlay/ \
 && cp -rf /tmp/s6-overlay/bin/* /bin/ \
 && cp -rf /tmp/s6-overlay/sbin/* /sbin/ \
 && rm -rf /tmp/s6-overlay/bin /tmp/s6-overlay/sbin \
           /tmp/s6-overlay/usr/bin/execlineb \
 && cp -rf /tmp/s6-overlay/* / \
 && rm -rf /tmp/s6-overlay*

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \
 && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        rsyslog \
        opendkim=2.10.3-5 \
 && rm -rf /var/lib/apt/lists/*


COPY rootfs /

RUN chmod +x /etc/services.d/*/run \

 && mkdir -p /run/opendkim \
 && chown -R opendkim:opendkim /run/opendkim


EXPOSE 8891


ENTRYPOINT ["/init"]

CMD ["opendkim", "-f", "-x", "/etc/opendkim/opendkim.conf"]

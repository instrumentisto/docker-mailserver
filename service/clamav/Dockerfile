FROM alpine:3.4


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


RUN apk add --update --no-cache \
        clamav=0.99.2-r1 \
        clamav-libunrar=0.99.2-r1 \
 && rm -rf /var/cache/apk/*

COPY rootfs /

RUN chmod +x /etc/services.d/*/run \

 && mkdir /run/clamav \
 && chown clamav:clamav /run/clamav \

 && sed -i -r 's/^#Foreground .*$/Foreground yes/g' /etc/clamav/clamd.conf \
 && sed -i -r 's/^#LogFileMaxSize .*$/LogFileMaxSize 0/g' /etc/clamav/clamd.conf \
 && sed -i -r 's/^#LogRotate .*$/LogRotate no/g' /etc/clamav/clamd.conf \

 && sed -i -r 's/^#Foreground .*$/Foreground yes/g' /etc/clamav/freshclam.conf \
 && sed -i -r 's/^(UpdateLogFile .*)$/#\1/g' /etc/clamav/freshclam.conf

RUN freshclam --log=/dev/null


EXPOSE 3310


ENTRYPOINT ["/init"]

CMD ["/usr/sbin/clamd"]

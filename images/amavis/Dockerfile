FROM alpine:3.4


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


ADD https://bitbucket.org/shlomif/perl-io-socket-inet6/raw/8c0bc129340e64e001b989de414cffd3dd1da882/modules/IO-Socket-INET6/lib/IO/Socket/INET6.pm /usr/share/perl5/vendor_perl/IO/Socket/INET6.pm

RUN chmod 444 /usr/share/perl5/vendor_perl/IO/Socket/INET6.pm \

 && apk add --update --no-cache \
        rsyslog \
        amavisd-new=2.10.1-r4 \
        perl-mail-spamassassin=3.4.1-r3 \
        perl-socket6 \
        bzip2 gzip p7zip unarj unrar lz4 cabextract \
 && rm -rf /var/cache/apk/*


COPY rootfs /

RUN chmod +x /etc/services.d/*/run \

 && mkdir -p /etc/amavis/conf.d/ \
 && mv /etc/amavisd.conf /etc/amavis/amavisd.conf \
 && ln -s /etc/amavis/amavisd.conf /etc/amavisd.conf \
 && cat /tmp/amavisd.conf.inc >> /etc/amavis/amavisd.conf \
 && rm -rf /tmp/amavisd.conf.inc


EXPOSE 10024


ENTRYPOINT ["/init"]

CMD ["amavisd", "foreground"]

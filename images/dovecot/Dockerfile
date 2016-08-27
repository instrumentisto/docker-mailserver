FROM alpine:3.4


RUN apk add --update --no-cache \
        tini \
        dovecot=2.2.24-r1 \
 && rm -rf /var/cache/apk/* \

 && sed -i -r 's/^#log_path = syslog$/log_path = \/dev\/stdout/g' /etc/dovecot/conf.d/10-logging.conf


EXPOSE 143 993 110 995


ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/sbin/dovecot", "-F"]

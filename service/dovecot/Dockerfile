FROM alpine:3.4

RUN apk add --update --no-cache tini \
# && apk add --update --no-cache bash \
 && apk add --update --no-cache dovecot=2.2.24-r1

ENTRYPOINT ["/sbin/tini", "--"]

EXPOSE 143 993 110 995

CMD ["/usr/sbin/dovecot", "-F"]

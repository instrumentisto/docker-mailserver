FROM alpine:3.4

RUN apk add --update --no-cache tini \
# && apk add --update --no-cache bash \
 && apk add --update --no-cache postfix=3.1.1-r0

ENTRYPOINT ["/sbin/tini", "--"]

EXPOSE 25 465 587

CMD ["/usr/lib/postfix/master", "-d"]

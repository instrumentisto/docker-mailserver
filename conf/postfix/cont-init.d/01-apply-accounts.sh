#!/bin/sh

ACCOUNTS_CONF_DIR=/etc/mailserver

if [ -f $ACCOUNTS_CONF_DIR/accounts.cf ]; then
  while IFS=$'|' read login pass; do
    user=$(echo ${login} | cut -d @ -f1)
    domain=$(echo ${login} | cut -d @ -f2)

    echo "${login} ${domain}/${user}/" >> /etc/postfix/vmailboxes
    echo "${domain}" >> /tmp/vhosts.tmp
  done < $ACCOUNTS_CONF_DIR/accounts.cf
fi
touch /etc/postfix/vmailboxes

if [ -f $ACCOUNTS_CONF_DIR/aliases.cf ]; then
  cp -f $ACCOUNTS_CONF_DIR/aliases.cf /etc/postfix/valiases
  while read from to; do
    uname=$(echo ${from} | cut -d @ -f1)
    domain=$(echo ${from} | cut -d @ -f2)
    # if they are equal it means the line looks like:
    # "user1     other@domain.tld"
    test "$uname" != "$domain" \
      && echo ${domain} >> /tmp/vhosts.tmp
  done < $ACCOUNTS_CONF_DIR/aliases.cf
fi
touch /etc/postfix/valiases

if [ -f /tmp/vhosts.tmp ]; then
  cat /tmp/vhosts.tmp | sort | uniq > /etc/postfix/vhosts
  rm -rf /tmp/vhosts.tmp
fi
touch /etc/postfix/vhosts

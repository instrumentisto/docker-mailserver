#!/bin/sh

ACCOUNTS_CONF_DIR=/etc/mailserver
CONF_FILE=/etc/amavis/conf.d/90-domains.conf

if [ -f $ACCOUNTS_CONF_DIR/accounts.cf ]; then
  while IFS=$'|' read login pass; do
    domain=$(echo ${login} | cut -d @ -f2)
    echo "${domain}" >> /tmp/vhosts.tmp
  done < $ACCOUNTS_CONF_DIR/accounts.cf
fi

if [ -f $ACCOUNTS_CONF_DIR/aliases.cf ]; then
  while read from to; do
    uname=$(echo ${from} | cut -d @ -f1)
    domain=$(echo ${from} | cut -d @ -f2)
    # if they are equal it means the line looks like:
    # "user1     other@domain.tld"
    test "$uname" != "$domain" \
      && echo ${domain} >> /tmp/vhosts.tmp
  done < $ACCOUNTS_CONF_DIR/aliases.cf
fi

if [ -f /tmp/vhosts.tmp ]; then
  echo '@local_domains_maps = ( [".$mydomain"' > $CONF_FILE
  for i in `cat /tmp/vhosts.tmp | sort | uniq`; do
    echo ", '${i}'" >> $CONF_FILE
  done
  echo '] );' >> $CONF_FILE
  rm -rf /tmp/vhosts.tmp
fi

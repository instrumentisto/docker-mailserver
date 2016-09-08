#!/bin/sh


DKIM_SELECTOR=${DKIM_SELECTOR:=mail}
DKIM_DATA_DIR=${DKIM_DATA_DIR:=/var/opendkim}
CONF_DIR=${CONF_DIR:=/etc/mailserver}
OUTPUT_DIR=${OUTPUT_DIR:=/out}

#
# Part 1. Fetch domains
#
touch /tmp/vhost.tmp

# Getting domains from mail accounts
if [ -f $CONF_DIR/accounts.cf ]; then
  while IFS=$'|' read login pass
  do
    domain=$(echo ${login} | cut -d @ -f2)
    echo ${domain} >> /tmp/vhost.tmp
  done < $CONF_DIR/accounts.cf
fi

# Getting domains from mail aliases
if [ -f $CONF_DIR/aliases.cf ]; then
  while read from to
  do
    uname=$(echo ${from} | cut -d @ -f1)
    domain=$(echo ${from} | cut -d @ -f2)
    # if they are equal it means the line looks like: "user1   other@domain.tld"
    test "$uname" != "$domain" \
      && echo ${domain} >> /tmp/vhost.tmp
  done < $CONF_DIR/aliases.cf
fi

# Keeping unique entries
if [ -f /tmp/vhost.tmp ]; then
  cat /tmp/vhost.tmp | sort | uniq > /tmp/vhost
  # rm -f /tmp/vhost.tmp
fi

# Exit if no entries found
if [ ! -f /tmp/vhost ]; then
  echo "No entries found, no keys to make"
  exit 0
fi


#
# Part 2. Generate keys and DKIM tables
#
grep -vE '^(\s*$|#)' /tmp/vhost | while read domainname; do
  mkdir -p $OUTPUT_DIR/keys/$domainname

  if [ ! -f $OUTPUT_DIR/keys/$domainname/$DKIM_SELECTOR.private ]; then
    echo "Creating DKIM private $key $OUTPUT_DIR/keys/$domainname/$DKIM_SELECTOR.private"
    /usr/sbin/opendkim-genkey \
      --subdomains \
      --domain=$domainname \
      --selector=$DKIM_SELECTOR \
      -D $OUTPUT_DIR/keys/$domainname
  fi

  # Write to KeyTable if necessary
  keytableentry="$DKIM_SELECTOR._domainkey.$domainname $domainname:mail:$DKIM_DATA_DIR/keys/$domainname/$DKIM_SELECTOR.private"
  if [ ! -f $OUTPUT_DIR/KeyTable ]; then
    echo "Creating DKIM KeyTable"
    echo $keytableentry > $OUTPUT_DIR/KeyTable
  else
    if ! grep -q "$keytableentry" $OUTPUT_DIR/KeyTable ; then
        echo $keytableentry >> $OUTPUT_DIR/KeyTable
    fi
  fi

  # Write to SigningTable if necessary
  signingtableentry="*@$domainname $DKIM_SELECTOR._domainkey.$domainname"
  if [ ! -f $OUTPUT_DIR/SigningTable ]; then
    echo "Creating DKIM SigningTable"
    echo $signingtableentry > $OUTPUT_DIR/SigningTable
  else
    if ! grep -q "$signingtableentry" $OUTPUT_DIR/SigningTable ; then
      echo $signingtableentry >> $OUTPUT_DIR/SigningTable
    fi
  fi
done

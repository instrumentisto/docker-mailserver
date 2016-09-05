#!/bin/sh

ACCOUNTS_CONF_DIR=/etc/mailserver

if [ -f $ACCOUNTS_CONF_DIR/accounts.cf ]; then
  while IFS=$'|' read login pass; do
    user=$(echo ${login} | cut -d @ -f1)
    domain=$(echo ${login} | cut -d @ -f2)

    echo "${login}:${pass}:65534:65534::/var/mail/${domain}/${user}::" \
      >> /etc/dovecot/users

    umask -S 077
    if [ ! -d /var/mail/${domain} ]; then
      mkdir -p /var/mail/${domain}
      chown -R nobody:nobody /var/mail/${domain}
    fi
    if [ ! -d /var/mail/${domain}/${user} ]; then
      IFS='|'; for dir in `echo "|.Sent|.Trash|.Drafts"`; do
        IFS='|'; for subdir in `echo "cur|new|tmp"`; do
          mkdir -p /var/mail/${domain}/${user}/${dir}/${subdir}
        done
      done
      echo -e "INBOX\nSent\nTrash\nDrafts" \
        >> /var/mail/${domain}/${user}/subscriptions
      touch /var/mail/${domain}/${user}/.Sent/maildirfolder
      chown -R nobody:nobody /var/mail/${domain}/${user}
    fi
  done < $ACCOUNTS_CONF_DIR/accounts.cf
fi
touch /etc/dovecot/users

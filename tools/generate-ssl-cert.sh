#!/bin/sh

set -e
FQDN=${FQDN:=mail.domain.com}
OUTPUT_DIR=${OUTPUT_DIR:=/out}
set -x


#
# Step 1. Generate CA credentials if there is no one
#
if [ ! -f $OUTPUT_DIR/ca.key ]; then
  openssl genrsa -out $OUTPUT_DIR/ca.key 2048
  openssl req -x509 -new -nodes -days 10000 \
              -subj "/C=/ST=/L=/O=/CN=mailserver-ca" \
              -key $OUTPUT_DIR/ca.key \
              -out $OUTPUT_DIR/ca.crt
fi

#
# Step 2. Create private key and CSR for given FQDN
#
openssl genrsa -out $OUTPUT_DIR/$FQDN.key 2048
openssl req -new -subj "/C=/ST=/L=/O=/CN=$FQDN" \
            -key $OUTPUT_DIR/$FQDN.key \
            -out $OUTPUT_DIR/$FQDN.csr

#
# Step 3. Sign public key certificate with CA certificate
#
openssl x509 -req -days 3652 \
             -CA $OUTPUT_DIR/ca.crt -CAkey $OUTPUT_DIR/ca.key -CAcreateserial \
             -in $OUTPUT_DIR/$FQDN.csr \
             -out $OUTPUT_DIR/$FQDN.crt

#
# Step 4. Create combined certificate
#
cat $OUTPUT_DIR/$FQDN.key $OUTPUT_DIR/$FQDN.crt \
    > $OUTPUT_DIR/$FQDN-combined.pem

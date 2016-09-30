# Build configuration
#
# Usage:
# 	make dkim-config


DKIM_SELECTOR ?= mail
DKIM_DATA_DIR ?= /var/opendkim

dkim-config:
	docker run --rm -it \
		-v "$(PWD)/conf/accounts":/etc/mailserver:ro \
		-v "$(PWD)/tools":/tool \
		-v "$(PWD)/dkim-config":/out \
		-e DKIM_SELECTOR=$(DKIM_SELECTOR) \
		-e DKIM_DATA_DIR=$(DKIM_DATA_DIR) \
		quay.io/instrumentisto/opendkim \
		sh /tool/generate-dkim-config.sh


SSL_FQDN ?= mail.domain.com

ssl-cert:
	docker run --rm -it \
		-v "$(PWD)/conf/accounts":/etc/mailserver:ro \
		-v "$(PWD)/tools":/tool \
		-v "$(PWD)/ssl":/out \
		-e FQDN=$(SSL_FQDN) \
		centurylink/openssl \
		sh /tool/generate-ssl-cert.sh


.PHONY: dkim-config ssl-certs

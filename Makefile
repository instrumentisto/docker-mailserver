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


.PHONY: dkim-config

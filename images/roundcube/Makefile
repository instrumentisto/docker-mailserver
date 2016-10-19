# Build Roundcube image
#
# Usage:
# 	make (container|push|push-tags) [VERSION=...] [TAGS=t1,t2,...] [no-cache=(yes|no)]
# 	make all [VERSION=...] [TAGS=tag1,tag2,...] [no-cache=(yes|no)]
# 	make roundcube [ROUNDCUBE_VER=] [PHPBUILDER_VER=]

defaut: container


NAME := quay.io/instrumentisto/roundcube
VERSION ?= 1.2.2_c1.0
TAGS ?= 1,1.2,1.2.2,latest
no-cache ?= no

comma:= ,
empty:=
space:= $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

tags = $(subst $(comma), $(space), $(TAGS))

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))


container: roundcube
	docker build $(no-cache-arg) -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)


all: | clean container push push-tags


.PHONY: container push push-tags all


PHPBUILDER_VER ?= 7.0.12
ROUNDCUBE_VER ?= 1.2.2

roundcube:
	rm -rf ./tmp/roundcube
	mkdir -p ./tmp/roundcube
	cp ./build-roundcube.sh ./tmp/roundcube/
	docker run --rm -it \
		-v $(PWD)/tmp/roundcube:/out \
		-e ROUNDCUBE_VER=$(ROUNDCUBE_VER) \
		quay.io/instrumentisto/php-builder:$(PHPBUILDER_VER) \
		sh /out/build-roundcube.sh
	cp -rf ./tmp/roundcube/result/* ./rootfs/


clean:
	rm -rf ./tmp ./rootfs/var/www


.PHONY: clean roundcube

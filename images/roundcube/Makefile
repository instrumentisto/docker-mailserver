# Build Roundcube image
#
# Usage:
# 	make [VERSION=] [TAGS=t1,t2,...] (container|push|push-tags)
# 	make [PHPBUILDER_VER=] [ROUNDCUBE_VER=] roundcube

defaut: container


NAME = quay.io/instrumentisto/roundcube
VERSION ?= 1.2.1_c0.0
TAGS ?= 1,1.2,1.2.1,latest

comma:= ,
empty:=
space:= $(empty) $(empty)
tags := $(subst $(comma), $(space), $(TAGS))

container: roundcube
	docker build -t $(NAME):latest ./

container-nocache: clean roundcube
	docker build --no-cache -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)


PHPBUILDER_VER ?= 7.0.11
ROUNDCUBE_VER ?= 1.2.1

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

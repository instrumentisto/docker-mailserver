# Build OpenDKIM image
#
# Usage:
# 	make [VERSION=...] [TAGS=t1,t2,...] (container|push|push-tags)

defaut: container


NAME = quay.io/instrumentisto/opendkim
VERSION ?= 2.10.3_c1.0
TAGS ?= 2,2.10,2.10.3,latest

comma:= ,
empty:=
space:= $(empty) $(empty)
tags := $(subst $(comma), $(space), $(TAGS))

container:
	docker build -t $(NAME):latest ./

container-nocache:
	docker build --no-cache -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)

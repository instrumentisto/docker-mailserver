# Build Dovecot image
#
# Usage:
# 	make (container|push|push-tags) [VERSION=...] [TAGS=t1,t2,...] [no-cache=(yes|no)]
# 	make all [VERSION=...] [TAGS=tag1,tag2,...] [no-cache=(yes|no)]

defaut: container


NAME := quay.io/instrumentisto/dovecot
VERSION ?= 2.2.24_c0.1
TAGS ?= 2,2.2,2.2.24,latest
no-cache ?= no

comma:= ,
empty:=
space:= $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

tags = $(subst $(comma), $(space), $(TAGS))

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))


container:
	docker build $(no-cache-arg) -t $(NAME):latest ./

push:
	docker tag $(NAME):latest $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)

push-tags:
	$(foreach tag, $(tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
		docker push $(NAME):$(tag); \
	)


all: | container push push-tags


.PHONY: container push push-tags all

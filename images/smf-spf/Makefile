# Build smf-spf image
#
# Usage:
# 	make (container|push|push-tags) [VERSION=...] [TAGS=t1,t2,...] [no-cache=(yes|no)]
# 	make all [VERSION=...] [TAGS=tag1,tag2,...] [no-cache=(yes|no)]
# 	make smf-spf [GCC_VER=] [SMFSPF_VER=]

defaut: container


NAME := quay.io/instrumentisto/smf-spf
VERSION ?= 2.1.1_c0.1
TAGS ?= 2,2.1,2.1.1,latest
no-cache ?= no

comma:= ,
empty:=
space:= $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

tags = $(subst $(comma), $(space), $(TAGS))

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))


container: smf-spf
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


GCC_VER ?= latest
SMFSPF_VER ?= 2.1.1

smf-spf:
	rm -rf ./tmp/smf-spf
	mkdir -p ./tmp/smf-spf
	cp ./build-smf-spf.sh ./tmp/smf-spf/
	docker run --rm -it \
		-v $(PWD)/tmp/smf-spf:/out \
		-e SMFSPF_VER=$(SMFSPF_VER) \
		quay.io/instrumentisto/gcc:$(GCC_VER) \
		sh /out/build-smf-spf.sh
	cp -rf ./tmp/smf-spf/result/* ./rootfs/


clean:
	rm -rf ./tmp ./rootfs/usr


.PHONY: clean smf-spf
